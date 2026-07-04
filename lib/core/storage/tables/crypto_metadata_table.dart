import 'package:drift/drift.dart';
class CryptoMetadata extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get argon2Parameters => text()();
  IntColumn get algorithmVersion => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
