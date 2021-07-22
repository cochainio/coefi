import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'crypto.dart';
import 'mnemonic.dart';

export 'bip44.dart';
export 'crypto.dart';
export 'keystore.convert.dart';
export 'mnemonic.dart';

part 'keystore.g.dart';

enum KeystoreType {
  BTC, // ignore: constant_identifier_names
  BTCMnemonic, // ignore: constant_identifier_names
  ETH, // ignore: constant_identifier_names
  ETHMnemonic, // ignore: constant_identifier_names
}

@JsonSerializable()
class KeystoreMeta {
  KeystoreMeta();

  factory KeystoreMeta.fromJson(Map<String, dynamic> json) => _$KeystoreMetaFromJson(json);

  Map<String, dynamic> toJson() => _$KeystoreMetaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Keystore {
  String id;
  int version;
  late Crypto crypto;
  @JsonKey(includeIfNull: false)
  KeystoreMeta meta;

  static const defaultVersion = 3;

  Keystore({String? id, this.version = defaultVersion, Crypto? crypto, KeystoreMeta? meta})
      : id = id ?? const Uuid().v4(options: {'grng': UuidUtil.cryptoRNG}),
        meta = meta ?? KeystoreMeta() {
    if (crypto != null) {
      this.crypto = crypto;
    }
    preValidate();
  }

  factory Keystore.from(String password, Uint8List secret, {String? id, KeystoreMeta? meta, bool clearCache = true}) {
    final k = Keystore(id: id, meta: meta);
    k.crypto = Crypto.from(password, secret, cacheDerivedKey: !clearCache);
    return k;
  }

  void cacheDerivedKey(String password) {
    crypto.cacheDerivedKey(password);
  }

  void clearCache() {
    crypto.clearCache();
  }

  void preValidate() {
    if (version != defaultVersion) {
      throw ArgumentError.value(version, 'version');
    }
  }

  bool validate(String password, {bool willThrow = false, bool cacheDerivedKey = false}) {
    return crypto.validate(password, willThrow: willThrow, cacheDerivedKey: cacheDerivedKey);
  }

  void changePassword(String password, String newPassword, {bool cacheDerivedKey = false}) {
    validate(password, willThrow: true, cacheDerivedKey: true);
    final secret = crypto.secret(password);
    crypto = Crypto.from(newPassword, secret, cacheDerivedKey: cacheDerivedKey);
  }

  Uint8List secret(String password) {
    return crypto.secret(password);
  }

  String export() {
    return jsonEncode(this);
  }

  factory Keystore.fromJson(Map<String, dynamic> json) => _$KeystoreFromJson(json);

  Map<String, dynamic> toJson() => _$KeystoreToJson(this);
}

@JsonSerializable()
class MnemonicKeystore extends Keystore {
  late EncryptedMessage encryptedMnemonic;
  late EncryptedMessage encryptedExtendedPrivateKey;
  String? hdPath;

  MnemonicKeystore();

  /// If [hdPath] is not given, the master key seeded from [mnemonic] is persisted into [crypto]. Otherwise,
  /// the derived key corresponding to [hdPath] is persisted.
  /// [isMainnet] = false is only useful for BTC-like testnet.
  MnemonicKeystore.from(String password,
      {String? mnemonic,
      String? language,
      this.hdPath,
      bool isMainnet = true,
      String? id,
      KeystoreMeta? meta,
      bool clearCache = true})
      : super(id: id, meta: meta) {
    // Generate random mnemonic
    mnemonic ??= Mnemonic.generateMnemonic(language);

    final master = BIP32.fromSeed(Mnemonic.mnemonicToSeed(mnemonic), isMainnet ? BITCOIN : TESTNET);
    final extendedPrivateKey = hdPath == null ? master : master.derivePath(hdPath!);
    crypto = Crypto.from(password, extendedPrivateKey.privateKey!, cacheDerivedKey: true);
    encryptedMnemonic = crypto.encryptMessage(password, utf8.encode(mnemonic) as Uint8List);
    encryptedExtendedPrivateKey =
        crypto.encryptMessage(password, utf8.encode(extendedPrivateKey.toBase58()) as Uint8List);
    if (clearCache) this.clearCache();
  }

  @override
  void changePassword(String password, String newPassword, {bool cacheDerivedKey = false}) {
    this.cacheDerivedKey(password);
    final mnemonic = this.mnemonic(password);
    final extendedPrivateKey = base58(password);
    super.changePassword(password, newPassword, cacheDerivedKey: true);
    encryptedMnemonic = crypto.encryptMessage(newPassword, utf8.encode(mnemonic) as Uint8List);
    encryptedExtendedPrivateKey = crypto.encryptMessage(newPassword, utf8.encode(extendedPrivateKey) as Uint8List);
    if (!cacheDerivedKey) clearCache();
  }

  String mnemonic(String password) {
    return utf8.decode(crypto.decryptMessage(password, encryptedMnemonic));
  }

  BIP32 extendedPrivateKey(String password) {
    return BIP32.fromBase58(base58(password));
  }

  String base58(String password) {
    return utf8.decode(crypto.decryptMessage(password, encryptedExtendedPrivateKey));
  }

  factory MnemonicKeystore.fromJson(Map<String, dynamic> json) {
    final k = _$MnemonicKeystoreFromJson(json);
    k.preValidate();
    return k;
  }

  @override
  Map<String, dynamic> toJson() => _$MnemonicKeystoreToJson(this);
}
