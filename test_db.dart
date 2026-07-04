import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_vault/core/storage/database.dart';

void main() async {
  final db = AppDatabase(NativeDatabase.memory());
  await db.customSelect('SELECT 1').get();
  final tables = await db.customSelect('SELECT name FROM sqlite_master WHERE type="table"').get();
  print(tables.map((row) => row.read<String>('name')).toList());
  await db.close();
}
