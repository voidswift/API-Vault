import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_vault/core/storage/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    // Open in-memory DB for tests
    db = AppDatabase(NativeDatabase.memory(logStatements: true));
  });

  tearDown(() async {
    await db.close();
  });

  test('Database can be created and migrations run (V1 -> V1)', () async {
    // Force DB initialization
    await db.customSelect('SELECT 1').get();
    
    // Test that we can access the tables
    final categories = await db.select(db.categories).get();
    expect(categories, isEmpty);
  });

  test('CRUD for encrypted payload', () async {
    final payload = Uint8List.fromList([1, 2, 3, 4]);
    final nonce = Uint8List.fromList([5, 6, 7]);
    
    final secretId = 'secret_1';
    
    await db.vaultDao.addSecret(
      VaultItemsCompanion.insert(
        id: secretId,
        encryptedPayload: payload,
        nonce: nonce,
        algorithmVersion: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      AuditLogsCompanion.insert(
        id: 'audit_1',
        action: 'Secret Added',
        timestamp: DateTime.now(),
        itemId: const Value('secret_1'),
      ),
    );

    final secrets = await db.vaultDao.getAllSecrets();
    expect(secrets.length, 1);
    expect(secrets.first.id, secretId);
    expect(secrets.first.encryptedPayload, payload);
    
    await db.vaultDao.deleteSecret(
      secretId,
      AuditLogsCompanion.insert(
        id: 'audit_2',
        action: 'Secret Deleted',
        timestamp: DateTime.now(),
        itemId: const Value.absent(), // Record deletion without foreign key crash
      ),
    );
    
    final emptySecrets = await db.vaultDao.getAllSecrets();
    expect(emptySecrets.isEmpty, true);
  });

  test('Foreign key enforcement and Cascade Delete', () async {
    final categoryId = 'cat_1';
    
    await db.into(db.categories).insert(
      CategoriesCompanion.insert(
        id: categoryId,
        name: 'AWS',
        createdAt: DateTime.now(),
      ),
    );
    
    await db.into(db.vaultItems).insert(
      VaultItemsCompanion.insert(
        id: 'secret_with_category',
        encryptedPayload: Uint8List(0),
        nonce: Uint8List(0),
        algorithmVersion: 1,
        categoryId: Value(categoryId),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    
    // Setup for cascade delete test
    await db.into(db.tags).insert(
      TagsCompanion.insert(id: 'tag_1', name: 'prod'),
    );
    await db.into(db.itemTags).insert(
      ItemTagsCompanion.insert(itemId: 'secret_with_category', tagId: 'tag_1'),
    );
    
    var links = await db.select(db.itemTags).get();
    expect(links.length, 1);
    
    // Delete Vault Item, cascade should delete ItemTags
    await db.delete(db.vaultItems).go();
    
    links = await db.select(db.itemTags).get();
    expect(links.isEmpty, true); // Cascaded delete
  });

  test('Transaction rollback', () async {
    try {
      await db.transaction(() async {
        await db.into(db.tags).insert(
          TagsCompanion.insert(id: 'tag_fail', name: 'temp'),
        );
        throw Exception('Simulated Failure');
      });
    } catch (_) {}
    
    final tags = await db.select(db.tags).get();
    expect(tags.isEmpty, true);
  });

  test('Unique constraint validation', () async {
    await db.into(db.tags).insert(
      TagsCompanion.insert(id: 'tag_a', name: 'DuplicateName'),
    );
    
    expect(
      () => db.into(db.tags).insert(
        TagsCompanion.insert(id: 'tag_b', name: 'DuplicateName'),
      ),
      throwsA(isA<SqliteException>()),
    );
  });
}
