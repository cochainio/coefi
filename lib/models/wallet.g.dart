// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletMeta _$WalletMetaFromJson(Map<String, dynamic> json) {
  return WalletMeta(
    keystoreType: _$enumDecode(_$KeystoreTypeEnumMap, json['keystoreType']),
    backedUp: json['backedUp'] as bool,
    showTokens: json['showTokens'] as bool,
    avatar: json['avatar'] as String?,
  );
}

Map<String, dynamic> _$WalletMetaToJson(WalletMeta instance) =>
    <String, dynamic>{
      'keystoreType': _$KeystoreTypeEnumMap[instance.keystoreType],
      'backedUp': instance.backedUp,
      'showTokens': instance.showTokens,
      'avatar': instance.avatar,
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

const _$KeystoreTypeEnumMap = {
  KeystoreType.BTC: 'BTC',
  KeystoreType.BTCMnemonic: 'BTCMnemonic',
  KeystoreType.ETH: 'ETH',
  KeystoreType.ETHMnemonic: 'ETHMnemonic',
};

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$WalletsDAOMixin on DatabaseAccessor<SQLDatabase> {
  $WalletTableTable get walletTable => attachedDatabase.walletTable;
}
