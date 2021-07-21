import 'package:json_annotation/json_annotation.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/credentials.dart' hide Wallet;

import '../keystore.dart';

part 'ethkeystore.g.dart';

String _ethereumAddressToJson(EthereumAddress a) => a.hex;

EthereumAddress _ethereumAddressFromJson(String a) => EthereumAddress.fromHex(a);

@JsonSerializable()
class ETHKeystore extends Keystore {
  late String publicKey;
  @JsonKey(toJson: _ethereumAddressToJson, fromJson: _ethereumAddressFromJson)
  late EthereumAddress address;

  ETHKeystore();

  ETHKeystore.from(String password, String privateKey, {String? id, KeystoreMeta? meta, bool clearCache = true})
      : super(id: id, meta: meta) {
    final privateKeyBytes = hexToBytes(privateKey);
    if (privateKeyBytes.length != 64) throw ArgumentError.value(privateKey, 'privateKey');
    crypto = Crypto.from(password, hexToBytes(privateKey), cacheDerivedKey: !clearCache);
    final publicKeyBytes = privateKeyBytesToPublic(privateKeyBytes);
    publicKey = bytesToHex(publicKeyBytes);
    address = EthereumAddress.fromPublicKey(publicKeyBytes);
  }

  String privateKey(String password) {
    return bytesToHex(crypto.secret(password));
  }

  factory ETHKeystore.fromJson(Map<String, dynamic> json) {
    final k = _$ETHKeystoreFromJson(json);
    k.preValidate();
    return k;
  }

  @override
  Map<String, dynamic> toJson() => _$ETHKeystoreToJson(this);
}

@JsonSerializable()
class ETHMnemonicKeystore extends MnemonicKeystore {
  late String publicKey;
  @JsonKey(toJson: _ethereumAddressToJson, fromJson: _ethereumAddressFromJson)
  late EthereumAddress address;

  ETHMnemonicKeystore();

  ETHMnemonicKeystore.from(String password,
      {String? mnemonic, String? language, String? hdPath, String? id, KeystoreMeta? meta, bool clearCache = true})
      : super.from(password,
            mnemonic: mnemonic,
            language: language,
            hdPath: hdPath ?? BIP44.ETH,
            id: id,
            meta: meta,
            clearCache: false) {
    final publicKeyBytes = privateKeyBytesToPublic(crypto.secret(password));
    publicKey = bytesToHex(publicKeyBytes);
    address = EthereumAddress.fromPublicKey(publicKeyBytes);
    if (clearCache) this.clearCache();
  }

  String privateKey(String password) {
    return bytesToHex(crypto.secret(password));
  }

  factory ETHMnemonicKeystore.fromJson(Map<String, dynamic> json) {
    final k = _$ETHMnemonicKeystoreFromJson(json);
    k.preValidate();
    return k;
  }

  @override
  Map<String, dynamic> toJson() => _$ETHMnemonicKeystoreToJson(this);
}
