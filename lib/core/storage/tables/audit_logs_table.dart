import 'package:drift/drift.dart';
import 'vault_items_table.dart';
class AuditLogs extends Table {
  TextColumn get id => text()();
  TextColumn get action => text()();
  TextColumn get itemId => text().nullable().references(VaultItems, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get timestamp => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
