// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keystore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeystoreMeta _$KeystoreMetaFromJson(Map<String, dynamic> json) {
  return KeystoreMeta();
}

Map<String, dynamic> _$KeystoreMetaToJson(KeystoreMeta instance) =>
    <String, dynamic>{};

Keystore _$KeystoreFromJson(Map<String, dynamic> json) {
  return Keystore(
    id: json['id'] as String?,
    version: json['version'] as int,
    crypto: json['crypto'] == null
        ? null
        : Crypto.fromJson(json['crypto'] as Map<String, dynamic>),
    meta: json['meta'] == null
        ? null
        : KeystoreMeta.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$KeystoreToJson(Keystore instance) => <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'crypto': instance.crypto.toJson(),
      'meta': instance.meta.toJson(),
    };

MnemonicKeystore _$MnemonicKeystoreFromJson(Map<String, dynamic> json) {
  return MnemonicKeystore()
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

Map<String, dynamic> _$MnemonicKeystoreToJson(MnemonicKeystore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'crypto': instance.crypto,
      'meta': instance.meta,
      'encryptedMnemonic': instance.encryptedMnemonic,
      'encryptedExtendedPrivateKey': instance.encryptedExtendedPrivateKey,
      'hdPath': instance.hdPath,
    };
