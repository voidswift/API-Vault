import 'package:drift/drift.dart';
import 'vault_items_table.dart';
import 'tags_table.dart';

class ItemTags extends Table {
  TextColumn get itemId =>
      text().references(VaultItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();
  @override
  Set<Column> get primaryKey => {itemId, tagId};
}
