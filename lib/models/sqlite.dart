import 'package:moor/moor.dart';
import 'dart:io';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'wallet.dart';

part 'sqlite.g.dart';

const kDatabaseFilename = 'database.db';

LazyDatabase openDatabase({String databaseFilename = kDatabaseFilename}) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, databaseFilename));
    return VmDatabase(file);
  });
}

@UseMoor(
  tables: [WalletTable],
  daos: [WalletsDAO],
)
class SQLDatabase extends _$SQLDatabase {
  SQLDatabase() : super(openDatabase());

  @override
  int get schemaVersion => 1;

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities {
    return [
      ...super.allSchemaEntities,
      Index('wallet_sort_order', 'CREATE UNIQUE INDEX IF NOT EXISTS wallet_sort_order ON wallet_table(sort_order)'),
      Index('wallet_name', 'CREATE UNIQUE INDEX IF NOT EXISTS wallet_name ON wallet_table(name)'),
    ];
  }
}

SQLDatabase sqlSingleton = SQLDatabase();
