import 'package:drift/drift.dart';
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();
  @override
  Set<Column> get primaryKey => {id};
}
