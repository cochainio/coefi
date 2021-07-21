// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ethkeystore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ETHKeystore _$ETHKeystoreFromJson(Map<String, dynamic> json) {
  return ETHKeystore()
    ..id = json['id'] as String
    ..version = json['version'] as int
    ..crypto = Crypto.fromJson(json['crypto'] as Map<String, dynamic>)
    ..meta = KeystoreMeta.fromJson(json['meta'] as Map<String, dynamic>)
    ..publicKey = json['publicKey'] as String
    ..address = _ethereumAddressFromJson(json['address'] as String);
}

Map<String, dynamic> _$ETHKeystoreToJson(ETHKeystore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'crypto': instance.crypto,
      'meta': instance.meta,
      'publicKey': instance.publicKey,
      'address': _ethereumAddressToJson(instance.address),
    };

ETHMnemonicKeystore _$ETHMnemonicKeystoreFromJson(Map<String, dynamic> json) {
  return ETHMnemonicKeystore()
    ..id = json['id'] as String
    ..version = json['version'] as int
    ..crypto = Crypto.fromJson(json['crypto'] as Map<String, dynamic>)
    ..meta = KeystoreMeta.fromJson(json['meta'] as Map<String, dynamic>)
    ..encryptedMnemonic = EncryptedMessage.fromJson(
        json['encryptedMnemonic'] as Map<String, dynamic>)
    ..encryptedExtendedPrivateKey = EncryptedMessage.fromJson(
        json['encryptedExtendedPrivateKey'] as Map<String, dynamic>)
    ..hdPath = json['hdPath'] as String?
    ..publicKey = json['publicKey'] as String
    ..address = _ethereumAddressFromJson(json['address'] as String);
}

Map<String, dynamic> _$ETHMnemonicKeystoreToJson(
        ETHMnemonicKeystore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'crypto': instance.crypto,
      'meta': instance.meta,
      'encryptedMnemonic': instance.encryptedMnemonic,
      'encryptedExtendedPrivateKey': instance.encryptedExtendedPrivateKey,
      'hdPath': instance.hdPath,
      'publicKey': instance.publicKey,
      'address': _ethereumAddressToJson(instance.address),
    };
