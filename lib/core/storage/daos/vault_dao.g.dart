// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_dao.dart';

// ignore_for_file: type=lint
mixin _$VaultDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
  $VaultItemsTable get vaultItems => attachedDatabase.vaultItems;
  $AuditLogsTable get auditLogs => attachedDatabase.auditLogs;
  VaultDaoManager get managers => VaultDaoManager(this);
}

class VaultDaoManager {
  final _$VaultDaoMixin _db;
  VaultDaoManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$VaultItemsTableTableManager get vaultItems =>
      $$VaultItemsTableTableManager(_db.attachedDatabase, _db.vaultItems);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db.attachedDatabase, _db.auditLogs);
}
