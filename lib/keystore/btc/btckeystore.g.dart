// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btckeystore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BTCKeystore _$BTCKeystoreFromJson(Map<String, dynamic> json) {
  return BTCKeystore()
    ..id = json['id'] as String
    ..version = json['version'] as int
    ..crypto = Crypto.fromJson(json['crypto'] as Map<String, dynamic>)
    ..meta = KeystoreMeta.fromJson(json['meta'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BTCKeystoreToJson(BTCKeystore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'crypto': instance.crypto,
      'meta': instance.meta,
    };

BTCMnemonicKeystore _$BTCMnemonicKeystoreFromJson(Map<String, dynamic> json) {
  return BTCMnemonicKeystore()
    ..id = json['id'] as String
    ..version = json['version'] as int
    ..crypto = Crypto.fromJson(json['crypto'] as Map<String, dynamic>)
    ..meta = KeystoreMeta.fromJson(json['meta'] as Map<String, dynamic>)
    ..encryptedMnemonic = EncryptedMessage.fromJson(
        json['encryptedMnemonic'] as Map<String, dynamic>)
    ..encryptedExtendedPrivateKey = EncryptedMessage.fromJson(
        json['encryptedExtendedPrivateKey'] as Map<String, dynamic>)
    ..hdPath = json['hdPath'] as String?;
}

Map<String, dynamic> _$BTCMnemonicKeystoreToJson(
        BTCMnemonicKeystore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'crypto': instance.crypto,
      'meta': instance.meta,
      'encryptedMnemonic': instance.encryptedMnemonic,
      'encryptedExtendedPrivateKey': instance.encryptedExtendedPrivateKey,
      'hdPath': instance.hdPath,
    };
