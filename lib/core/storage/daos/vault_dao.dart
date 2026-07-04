import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/vault_items_table.dart';
import '../tables/audit_logs_table.dart';
part 'vault_dao.g.dart';

@DriftAccessor(tables: [VaultItems, AuditLogs])
class VaultDao extends DatabaseAccessor<AppDatabase> with _$VaultDaoMixin {
  VaultDao(super.db);

  Future<void> addSecret(
    VaultItemsCompanion secret,
    AuditLogsCompanion auditLog,
  ) {
    return transaction(() async {
      await into(vaultItems).insert(secret);
      await into(auditLogs).insert(auditLog);
    });
  }

  Future<List<VaultItem>> getAllSecrets() {
    return select(vaultItems).get();
  }

  Future<void> deleteSecret(String id, AuditLogsCompanion auditLog) {
    return transaction(() async {
      await (delete(vaultItems)..where((t) => t.id.equals(id))).go();
      await into(auditLogs).insert(auditLog);
    });
  }
}
