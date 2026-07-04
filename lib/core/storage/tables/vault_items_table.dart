import 'package:drift/drift.dart';
import 'categories_table.dart';

class VaultItems extends Table {
  TextColumn get id => text()();
  BlobColumn get encryptedPayload => blob()();
  BlobColumn get nonce => blob()();
  IntColumn get algorithmVersion => integer()();
  TextColumn get categoryId => text().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
}
