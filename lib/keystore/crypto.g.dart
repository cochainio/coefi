// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CipherParams _$CipherParamsFromJson(Map<String, dynamic> json) {
  return CipherParams()..iv = hexToBytes(json['iv'] as String);
}

Map<String, dynamic> _$CipherParamsToJson(CipherParams instance) =>
    <String, dynamic>{
      'iv': bytesToHex(instance.iv),
    };

PBKDF2KdfDerivator _$PBKDF2KdfDerivatorFromJson(Map<String, dynamic> json) {
  return PBKDF2KdfDerivator(
    c: json['c'] as int,
    dklen: json['dklen'] as int,
    salt: hexToBytes(json['salt'] as String),
    prf: json['prf'] as String,
  );
}

Map<String, dynamic> _$PBKDF2KdfDerivatorToJson(PBKDF2KdfDerivator instance) =>
    <String, dynamic>{
      'c': instance.c,
      'dklen': instance.dklen,
      'prf': instance.prf,
      'salt': bytesToHex(instance.salt),
    };

ScryptKdfDerivator _$ScryptKdfDerivatorFromJson(Map<String, dynamic> json) {
  return ScryptKdfDerivator(
    dklen: json['dklen'] as int,
    n: json['n'] as int,
    r: json['r'] as int,
    p: json['p'] as int,
    salt: hexToBytes(json['salt'] as String),
  );
}

Map<String, dynamic> _$ScryptKdfDerivatorToJson(ScryptKdfDerivator instance) =>
    <String, dynamic>{
      'dklen': instance.dklen,
      'n': instance.n,
      'r': instance.r,
      'p': instance.p,
      'salt': bytesToHex(instance.salt),
    };

EncryptedMessage _$EncryptedMessageFromJson(Map<String, dynamic> json) {
  return EncryptedMessage(
    hexToBytes(json['cipherText'] as String),
    hexToBytes(json['nonce'] as String),
  );
}

Map<String, dynamic> _$EncryptedMessageToJson(EncryptedMessage instance) =>
    <String, dynamic>{
      'cipherText': bytesToHex(instance.cipherText),
      'nonce': bytesToHex(instance.nonce),
    };

Crypto _$CryptoFromJson(Map<String, dynamic> json) {
  return Crypto(
    cipher: _$enumDecode(_$CipherEnumMap, json['cipher']),
    cipherParams:
        CipherParams.fromJson(json['cipherparams'] as Map<String, dynamic>),
    cipherText: hexToBytes(json['ciphertext'] as String),
    kdf: _$enumDecode(_$KdfEnumMap, json['kdf']),
    kdfParams: KdfDerivator.fromJson(json['kdfparams'] as Map<String, dynamic>),
    mac: json['mac'] as String,
  );
}

Map<String, dynamic> _$CryptoToJson(Crypto instance) => <String, dynamic>{
      'cipher': _$CipherEnumMap[instance.cipher],
      'cipherparams': instance.cipherParams,
      'ciphertext': bytesToHex(instance.cipherText),
      'kdf': _$KdfEnumMap[instance.kdf],
      'kdfparams': instance.kdfParams,
      'mac': instance.mac,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$CipherEnumMap = {
  Cipher.aes128Ctr: 'aes-128-ctr',
  Cipher.aes128Cbc: 'aes-128-cbc',
};

const _$KdfEnumMap = {
  Kdf.pbkdf2: 'pbkdf2',
  Kdf.scrypt: 'scrypt',
};
