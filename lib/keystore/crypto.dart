import 'dart:typed_data';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pointycastle/export.dart';
import 'package:web3dart/crypto.dart';

import 'random.dart';

export 'package:web3dart/crypto.dart' show bytesToHex, hexToBytes;

part 'crypto.g.dart';

// Version 3 of the Web3 Secret Storage Definition
// https://github.com/ethereum/wiki/wiki/Web3-Secret-Storage-Definition

enum Cipher {
  @JsonValue('aes-128-ctr')
  aes128Ctr, // AES-128-CTR is the minimal requirement
  @JsonValue('aes-128-cbc')
  aes128Cbc, // Version 1 fixed algorithm
}

enum Kdf {
  pbkdf2,
  scrypt,
}

@JsonSerializable()
class CipherParams {
  CipherParams() : iv = CryptoRandom.global.nextBytes(128 ~/ 8);

  @JsonKey(toJson: bytesToHex, fromJson: hexToBytes)
  Uint8List iv; // 128-bit initialisation vector for the cipher

  factory CipherParams.fromJson(Map<String, dynamic> json) =>
      _$CipherParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CipherParamsToJson(this);
}

abstract class KdfDerivator {
  Uint8List deriveKey(Uint8List password); // time consuming!
  Map<String, dynamic> toJson();

  String get name;

  KdfDerivator();

  factory KdfDerivator.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("prf")) {
      return PBKDF2KdfDerivator.fromJson(json);
    } else {
      return ScryptKdfDerivator.fromJson(json);
    }
  }
}

// https://en.wikipedia.org/wiki/PBKDF2
@JsonSerializable()
class PBKDF2KdfDerivator extends KdfDerivator {
  PBKDF2KdfDerivator(
      {this.c = defaultC, this.dklen = 32, Uint8List? salt, this.prf = PRF})
      : salt = salt ?? CryptoRandom.global.nextBytes(32) {
    if (c <= 0 || dklen < 32 || prf != PRF || this.salt.isEmpty) {
      throw ArgumentError();
    }
  }

  static const int defaultC = 262144;

  // hmac-sha256 is the only mac supported at the moment
  // ignore: constant_identifier_names
  static const String PRF = 'hmac-sha256';

  final int c; // number of iterations
  final int dklen; // length for the derived key. Must be >= 32
  final String
      prf; // a pseudorandom function of two parameters with output length hLen (e.g. a keyed HMAC)
  @JsonKey(toJson: bytesToHex, fromJson: hexToBytes)
  Uint8List salt; // salt passed to PBKDF

  @override
  Uint8List deriveKey(Uint8List password) {
    final Mac mac = HMac(SHA256Digest(), 64);
    final impl = PBKDF2KeyDerivator(mac)
      ..init(Pbkdf2Parameters(salt, c, dklen));

    return impl.process(password);
  }

  factory PBKDF2KdfDerivator.fromJson(Map<String, dynamic> json) =>
      _$PBKDF2KdfDerivatorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PBKDF2KdfDerivatorToJson(this);

  @override
  @JsonKey(ignore: true)
  final String name = 'pbkdf2';
}

// https://en.wikipedia.org/wiki/Scrypt
@JsonSerializable()
class ScryptKdfDerivator extends KdfDerivator {
  ScryptKdfDerivator(
      {this.dklen = 32,
      this.n = defaultN,
      this.r = 8,
      this.p = 1,
      Uint8List? salt})
      : salt = salt ?? CryptoRandom.global.nextBytes(32) {
    if (dklen != 32 || n <= 0 || r <= 0 || p <= 0 || this.salt.isEmpty) {
      throw ArgumentError();
    }
  }

  static const int defaultN = 262144;

  final int
      dklen; // intended output length in octets of the derived key; a positive integer satisfying dkLen ≤ (232− 1) * hLen
  final int n; // CPU/memory cost parameter
  final int r; // RAM cost
  final int p; // CPU cost
  @JsonKey(toJson: bytesToHex, fromJson: hexToBytes)
  Uint8List salt;

  @override
  Uint8List deriveKey(Uint8List password) {
    final impl = Scrypt()..init(ScryptParameters(n, r, p, dklen, salt));

    return impl.process(password);
  }

  factory ScryptKdfDerivator.fromJson(Map<String, dynamic> json) =>
      _$ScryptKdfDerivatorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScryptKdfDerivatorToJson(this);

  @override
  @JsonKey(ignore: true)
  final String name = 'scrypt';
}

class CachedDerivedKey {
  String? _passwordHash;
  Uint8List? _derivedKey;

  void cache(Uint8List password, Uint8List derivedKey) {
    _passwordHash = _hash(password);
    _derivedKey = derivedKey;
  }

  Uint8List? get(Uint8List password) {
    if (_hash(password) == _passwordHash) {
      return _derivedKey;
    } else {
      return null;
    }
  }

  void clear() {
    _passwordHash = null;
    _derivedKey = null;
  }

  String _hash(Uint8List password) {
    final sha256 = SHA256Digest();
    var h = sha256.process(password);
    sha256.reset();
    h = sha256.process(h);
    return bytesToHex(h);
  }
}

@JsonSerializable()
class EncryptedMessage {
  @JsonKey(toJson: bytesToHex, fromJson: hexToBytes)
  Uint8List cipherText;
  @JsonKey(toJson: bytesToHex, fromJson: hexToBytes)
  Uint8List nonce;

  EncryptedMessage(this.cipherText, this.nonce);

  factory EncryptedMessage.fromJson(Map<String, dynamic> json) =>
      _$EncryptedMessageFromJson(json);

  Map<String, dynamic> toJson() => _$EncryptedMessageToJson(this);
}

@JsonSerializable()
class Crypto {
  Cipher cipher;
  @JsonKey(name: 'cipherparams')
  CipherParams cipherParams;
  @JsonKey(toJson: bytesToHex, fromJson: hexToBytes, name: 'ciphertext')
  Uint8List cipherText;
  Kdf kdf;
  @JsonKey(name: 'kdfparams')
  KdfDerivator
      kdfParams; // KDF-dependent static and dynamic parameters to the KDF function
  String
      mac; // SHA3 (keccak-256) of the concatenation of the last 16 bytes of the derived key together with the full ciphertext

  final CachedDerivedKey _cachedDerivedKey = CachedDerivedKey();

  Crypto(
      {required this.cipher,
      required this.cipherParams,
      required this.cipherText,
      required this.kdf,
      required this.kdfParams,
      required this.mac}) {
    if (!(kdf == Kdf.pbkdf2 && kdfParams is PBKDF2KdfDerivator) &&
        !(kdf == Kdf.scrypt && kdfParams is ScryptKdfDerivator)) {
      throw ArgumentError('invalid kdf parameters');
    }
    if (cipher == Cipher.aes128Cbc) {
      throw ArgumentError('only aes-128-ctr is supported');
    }
  }

  factory Crypto.from(String password, Uint8List secret,
      {KdfDerivator? kdfParams, bool cacheDerivedKey = false}) {
    var c = Crypto(
      cipher: Cipher.aes128Ctr,
      cipherParams: CipherParams(),
      cipherText: Uint8List(0),
      kdf: (kdfParams is PBKDF2KdfDerivator) ? Kdf.pbkdf2 : Kdf.scrypt,
      kdfParams: kdfParams ?? ScryptKdfDerivator(n: 8192),
      mac: '',
    );
    final derivedKey = c._deriveKey(password, true);
    c.cipherText = c._encryptOrDecrypt(password, secret, c.cipherParams.iv);
    c.mac = _generateMac(derivedKey, c.cipherText);
    if (!cacheDerivedKey) c.clearCache();
    return c;
  }

  Uint8List secret(String password) {
    return _encryptOrDecrypt(password, cipherText, cipherParams.iv);
  }

  bool validate(String password,
      {bool willThrow = false, bool cacheDerivedKey = false}) {
    final derivedKey = _deriveKey(password, cacheDerivedKey);
    final b = _generateMac(derivedKey, cipherText) == mac;
    if (!b && willThrow) throw ArgumentError.value(password, 'password');
    return b;
  }

  EncryptedMessage encryptMessage(String password, Uint8List message) {
    final nonce = CipherParams().iv;
    final cipherText = _encryptOrDecrypt(password, message, nonce);
    return EncryptedMessage(cipherText, nonce);
  }

  Uint8List decryptMessage(String password, EncryptedMessage message) {
    return _encryptOrDecrypt(password, message.cipherText, message.nonce);
  }

  Uint8List cacheDerivedKey(String password) {
    return _deriveKey(password, true);
  }

  void clearCache() {
    _cachedDerivedKey.clear();
  }

  Uint8List _deriveKey(String password, [bool cacheDerivedKey = false]) {
    final passwordBytes = Uint8List.fromList(utf8.encode(password));
    final cached = _cachedDerivedKey.get(passwordBytes);
    if (cached != null) return cached;

    final derivedKey = kdfParams.deriveKey(passwordBytes);
    if (cacheDerivedKey) {
      _cachedDerivedKey.cache(passwordBytes, derivedKey);
    }
    return derivedKey;
  }

  Uint8List _encryptOrDecrypt(String password, Uint8List data, Uint8List iv) {
    final derivedKey = _deriveKey(password);
    final aesKey = Uint8List.view(derivedKey.buffer, 0, 16);
    final cipher = CTRStreamCipher(AESFastEngine());
    // `forEncryption` is ignored
    cipher.init(true, ParametersWithIV(KeyParameter(aesKey), iv));
    return cipher.process(data);
  }

  static String _generateMac(Uint8List derivedKey, Uint8List cipherText) {
    final macBody = Uint8List.fromList(
        derivedKey.sublist(16, 32).toList()..addAll(cipherText));
    return bytesToHex(keccak256(macBody));
  }

  factory Crypto.fromJson(Map<String, dynamic> json) => _$CryptoFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoToJson(this);
}
