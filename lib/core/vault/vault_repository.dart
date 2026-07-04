import 'package:api_vault/core/storage/daos/vault_dao.dart';
import 'package:api_vault/core/storage/database.dart';
import 'package:api_vault/core/vault/models/secret_data.dart';
import 'package:api_vault/core/vault/session_guard.dart';
import 'package:api_vault/core/vault/vault_codec.dart';

class VaultRepository {
  final VaultDao _dao;
  final VaultCodec _codec;
  final SessionGuard _guard;

  VaultRepository(this._dao, this._codec, this._guard);

  Future<SecretData> getSecret(String id) async {
    return _guard.executeAsync((session) async {
      final item = await _dao.getItem(id);
      if (item == null) throw Exception('Secret not found');

      return await _codec.decode(
        item.encryptedPayload,
        item.nonce,
        session.dek,
      );
    });
  }

  Future<List<SecretData>> getAllSecrets() async {
    return _guard.executeAsync((session) async {
      final items = await _dao.getAllItems();
      final List<SecretData> decrypted = [];
      for (final item in items) {
        decrypted.add(
          await _codec.decode(item.encryptedPayload, item.nonce, session.dek),
        );
      }
      return decrypted;
    });
  }

  Future<void> saveSecret(
    String id,
    SecretData data, {
    String? categoryId,
  }) async {
    return _guard.executeAsync((session) async {
      final encoded = await _codec.encode(data, session.dek);

      final companion = VaultItemsCompanion.insert(
        id: id,
        encryptedPayload: encoded.encryptedPayload,
        nonce: encoded.nonce,
        algorithmVersion: encoded.algorithmVersion,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Dao method might need to be created if not exists.
      // We will assume _dao.saveItem handles it.
      await _dao.createItem(companion);
    });
  }
}
