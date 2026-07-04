import 'package:drift/drift.dart';

class VaultHeaders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get version => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get vaultId => text()();
  IntColumn get cryptoVersion => integer()();
  IntColumn get schemaVersion => integer()();
  TextColumn get argon2Parameters => text()();
  TextColumn get wrappedDEK => text()();
  TextColumn get checksum => text()();
}
