import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/vault_items_table.dart';
import 'tables/categories_table.dart';
import 'tables/tags_table.dart';
import 'tables/item_tags_table.dart';
import 'tables/audit_logs_table.dart';
import 'tables/settings_table.dart';
import 'tables/crypto_metadata_table.dart';
import 'daos/vault_dao.dart';
part 'database.g.dart';
@DriftDatabase(
  tables: [
    Categories,
    Tags,
    VaultItems,
    ItemTags,
    AuditLogs,
    Settings,
    CryptoMetadata,
  ],
  daos: [VaultDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
QueryExecutor _openConnection() {
  return driftDatabase(name: 'api_vault');
}
