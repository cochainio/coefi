// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqlite.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Wallet extends DataClass implements Insertable<Wallet> {
  String id;
  int sortOrder;
  String name;
  String coin;
  String publicKey;
  DateTime createdAt;
  Keystore keystore;
  WalletMeta meta;
  Map<String, dynamic> extra;
  Wallet(
      {required this.id,
      required this.sortOrder,
      required this.name,
      required this.coin,
      required this.publicKey,
      required this.createdAt,
      required this.keystore,
      required this.meta,
      required this.extra});
  factory Wallet.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Wallet(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sortOrder: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sort_order'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      coin: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}coin'])!,
      publicKey: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}public_key'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      keystore: $WalletTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}keystore']))!,
      meta: $WalletTableTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}meta']))!,
      extra: $WalletTableTable.$converter2.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}extra']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sort_order'] = Variable<int>(sortOrder);
    map['name'] = Variable<String>(name);
    map['coin'] = Variable<String>(coin);
    map['public_key'] = Variable<String>(publicKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      final converter = $WalletTableTable.$converter0;
      map['keystore'] = Variable<String>(converter.mapToSql(keystore)!);
    }
    {
      final converter = $WalletTableTable.$converter1;
      map['meta'] = Variable<String>(converter.mapToSql(meta)!);
    }
    {
      final converter = $WalletTableTable.$converter2;
      map['extra'] = Variable<String>(converter.mapToSql(extra)!);
    }
    return map;
  }

  WalletCompanion toCompanion(bool nullToAbsent) {
    return WalletCompanion(
      id: Value(id),
      sortOrder: Value(sortOrder),
      name: Value(name),
      coin: Value(coin),
      publicKey: Value(publicKey),
      createdAt: Value(createdAt),
      keystore: Value(keystore),
      meta: Value(meta),
      extra: Value(extra),
    );
  }

  factory Wallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Wallet(
      id: serializer.fromJson<String>(json['id']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      name: serializer.fromJson<String>(json['name']),
      coin: serializer.fromJson<String>(json['coin']),
      publicKey: serializer.fromJson<String>(json['publicKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      keystore: serializer.fromJson<Keystore>(json['keystore']),
      meta: serializer.fromJson<WalletMeta>(json['meta']),
      extra: serializer.fromJson<Map<String, dynamic>>(json['extra']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'name': serializer.toJson<String>(name),
      'coin': serializer.toJson<String>(coin),
      'publicKey': serializer.toJson<String>(publicKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'keystore': serializer.toJson<Keystore>(keystore),
      'meta': serializer.toJson<WalletMeta>(meta),
      'extra': serializer.toJson<Map<String, dynamic>>(extra),
    };
  }

  Wallet copyWith(
          {String? id,
          int? sortOrder,
          String? name,
          String? coin,
          String? publicKey,
          DateTime? createdAt,
          Keystore? keystore,
          WalletMeta? meta,
          Map<String, dynamic>? extra}) =>
      Wallet(
        id: id ?? this.id,
        sortOrder: sortOrder ?? this.sortOrder,
        name: name ?? this.name,
        coin: coin ?? this.coin,
        publicKey: publicKey ?? this.publicKey,
        createdAt: createdAt ?? this.createdAt,
        keystore: keystore ?? this.keystore,
        meta: meta ?? this.meta,
        extra: extra ?? this.extra,
      );
  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('id: $id, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('name: $name, ')
          ..write('coin: $coin, ')
          ..write('publicKey: $publicKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('keystore: $keystore, ')
          ..write('meta: $meta, ')
          ..write('extra: $extra')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          sortOrder.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  coin.hashCode,
                  $mrjc(
                      publicKey.hashCode,
                      $mrjc(
                          createdAt.hashCode,
                          $mrjc(keystore.hashCode,
                              $mrjc(meta.hashCode, extra.hashCode)))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.id == this.id &&
          other.sortOrder == this.sortOrder &&
          other.name == this.name &&
          other.coin == this.coin &&
          other.publicKey == this.publicKey &&
          other.createdAt == this.createdAt &&
          other.keystore == this.keystore &&
          other.meta == this.meta &&
          other.extra == this.extra);
}

class WalletCompanion extends UpdateCompanion<Wallet> {
  Value<String> id;
  Value<int> sortOrder;
  Value<String> name;
  Value<String> coin;
  Value<String> publicKey;
  Value<DateTime> createdAt;
  Value<Keystore> keystore;
  Value<WalletMeta> meta;
  Value<Map<String, dynamic>> extra;
  WalletCompanion({
    this.id = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.name = const Value.absent(),
    this.coin = const Value.absent(),
    this.publicKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.keystore = const Value.absent(),
    this.meta = const Value.absent(),
    this.extra = const Value.absent(),
  });
  WalletCompanion.insert({
    required String id,
    required int sortOrder,
    required String name,
    required String coin,
    required String publicKey,
    required DateTime createdAt,
    required Keystore keystore,
    required WalletMeta meta,
    required Map<String, dynamic> extra,
  })  : id = Value(id),
        sortOrder = Value(sortOrder),
        name = Value(name),
        coin = Value(coin),
        publicKey = Value(publicKey),
        createdAt = Value(createdAt),
        keystore = Value(keystore),
        meta = Value(meta),
        extra = Value(extra);
  static Insertable<Wallet> custom({
    Expression<String>? id,
    Expression<int>? sortOrder,
    Expression<String>? name,
    Expression<String>? coin,
    Expression<String>? publicKey,
    Expression<DateTime>? createdAt,
    Expression<Keystore>? keystore,
    Expression<WalletMeta>? meta,
    Expression<Map<String, dynamic>>? extra,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (name != null) 'name': name,
      if (coin != null) 'coin': coin,
      if (publicKey != null) 'public_key': publicKey,
      if (createdAt != null) 'created_at': createdAt,
      if (keystore != null) 'keystore': keystore,
      if (meta != null) 'meta': meta,
      if (extra != null) 'extra': extra,
    });
  }

  WalletCompanion copyWith(
      {Value<String>? id,
      Value<int>? sortOrder,
      Value<String>? name,
      Value<String>? coin,
      Value<String>? publicKey,
      Value<DateTime>? createdAt,
      Value<Keystore>? keystore,
      Value<WalletMeta>? meta,
      Value<Map<String, dynamic>>? extra}) {
    return WalletCompanion(
      id: id ?? this.id,
      sortOrder: sortOrder ?? this.sortOrder,
      name: name ?? this.name,
      coin: coin ?? this.coin,
      publicKey: publicKey ?? this.publicKey,
      createdAt: createdAt ?? this.createdAt,
      keystore: keystore ?? this.keystore,
      meta: meta ?? this.meta,
      extra: extra ?? this.extra,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coin.present) {
      map['coin'] = Variable<String>(coin.value);
    }
    if (publicKey.present) {
      map['public_key'] = Variable<String>(publicKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (keystore.present) {
      final converter = $WalletTableTable.$converter0;
      map['keystore'] = Variable<String>(converter.mapToSql(keystore.value)!);
    }
    if (meta.present) {
      final converter = $WalletTableTable.$converter1;
      map['meta'] = Variable<String>(converter.mapToSql(meta.value)!);
    }
    if (extra.present) {
      final converter = $WalletTableTable.$converter2;
      map['extra'] = Variable<String>(converter.mapToSql(extra.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletCompanion(')
          ..write('id: $id, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('name: $name, ')
          ..write('coin: $coin, ')
          ..write('publicKey: $publicKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('keystore: $keystore, ')
          ..write('meta: $meta, ')
          ..write('extra: $extra')
          ..write(')'))
        .toString();
  }
}

class $WalletTableTable extends WalletTable
    with TableInfo<$WalletTableTable, Wallet> {
  final GeneratedDatabase _db;
  final String? _alias;
  $WalletTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _sortOrderMeta = const VerificationMeta('sortOrder');
  late final GeneratedColumn<int?> sortOrder = GeneratedColumn<int?>(
      'sort_order', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _coinMeta = const VerificationMeta('coin');
  late final GeneratedColumn<String?> coin = GeneratedColumn<String?>(
      'coin', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _publicKeyMeta = const VerificationMeta('publicKey');
  late final GeneratedColumn<String?> publicKey = GeneratedColumn<String?>(
      'public_key', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _keystoreMeta = const VerificationMeta('keystore');
  late final GeneratedColumnWithTypeConverter<Keystore, String?> keystore =
      GeneratedColumn<String?>('keystore', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<Keystore>($WalletTableTable.$converter0);
  final VerificationMeta _metaMeta = const VerificationMeta('meta');
  late final GeneratedColumnWithTypeConverter<WalletMeta, String?> meta =
      GeneratedColumn<String?>('meta', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<WalletMeta>($WalletTableTable.$converter1);
  final VerificationMeta _extraMeta = const VerificationMeta('extra');
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String?>
      extra = GeneratedColumn<String?>('extra', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<Map<String, dynamic>>($WalletTableTable.$converter2);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sortOrder, name, coin, publicKey, createdAt, keystore, meta, extra];
  @override
  String get aliasedName => _alias ?? 'wallet_table';
  @override
  String get actualTableName => 'wallet_table';
  @override
  VerificationContext validateIntegrity(Insertable<Wallet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('coin')) {
      context.handle(
          _coinMeta, coin.isAcceptableOrUnknown(data['coin']!, _coinMeta));
    } else if (isInserting) {
      context.missing(_coinMeta);
    }
    if (data.containsKey('public_key')) {
      context.handle(_publicKeyMeta,
          publicKey.isAcceptableOrUnknown(data['public_key']!, _publicKeyMeta));
    } else if (isInserting) {
      context.missing(_publicKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    context.handle(_keystoreMeta, const VerificationResult.success());
    context.handle(_metaMeta, const VerificationResult.success());
    context.handle(_extraMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Wallet.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WalletTableTable createAlias(String alias) {
    return $WalletTableTable(_db, alias);
  }

  static TypeConverter<Keystore, String> $converter0 =
      const KeystoreConverter();
  static TypeConverter<WalletMeta, String> $converter1 =
      const WalletMetaConverter();
  static TypeConverter<Map<String, dynamic>, String> $converter2 =
      const WalletExtraConverter();
}

abstract class _$SQLDatabase extends GeneratedDatabase {
  _$SQLDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $WalletTableTable walletTable = $WalletTableTable(this);
  late final WalletsDAO walletsDAO = WalletsDAO(this as SQLDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [walletTable];
}
