/// Single-chain wallet [Wallet].

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moor/moor.dart';
import '../keystore/keystore.dart';
import 'sqlite.dart';
export '../keystore/keystore.dart';

part 'wallet.g.dart';

const int kWalletNameMaxLength = 128;

@DataClassName('Wallet')
class WalletTable extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  IntColumn get sortOrder => integer()();

  TextColumn get name =>
      text().withLength(max: kWalletNameMaxLength)(); // wallet name

  TextColumn get coin => text()(); // chain native coin

  TextColumn get publicKey => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get keystore => text().map(const KeystoreConverter())();

  TextColumn get meta => text().map(const WalletMetaConverter())();

  TextColumn get extra => text().map(const WalletExtraConverter())();
}

@JsonSerializable()
class WalletMeta {
  WalletMeta(
      {required this.keystoreType,
      this.backedUp = false,
      this.showTokens = false,
      this.avatar});

  KeystoreType keystoreType;
  bool backedUp;
  bool showTokens;
  String? avatar;

  factory WalletMeta.fromJson(Map<String, dynamic> json) =>
      _$WalletMetaFromJson(json);

  Map<String, dynamic> toJson() => _$WalletMetaToJson(this);
}

class WalletMetaConverter extends TypeConverter<WalletMeta, String> {
  const WalletMetaConverter();

  @override
  WalletMeta? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return WalletMeta.fromJson(json.decode(fromDb));
  }

  @override
  String? mapToSql(WalletMeta? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}

class WalletExtraConverter extends TypeConverter<Map<String, dynamic>, String> {
  const WalletExtraConverter();

  @override
  Map<String, dynamic>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return json.decode(fromDb);
  }

  @override
  String? mapToSql(Map<String, dynamic>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}

@UseDao(tables: [WalletTable])
class WalletsDAO extends DatabaseAccessor<SQLDatabase> with _$WalletsDAOMixin {
  WalletsDAO(SQLDatabase db) : super(db);
}
