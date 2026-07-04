import 'package:api_vault/core/crypto/key_derivation_service.dart';
import 'package:api_vault/core/crypto/key_management_service.dart';
import 'package:api_vault/core/crypto/secure_random_service.dart';
import 'package:api_vault/core/storage/database.dart';
import 'package:api_vault/core/vault/vault_session.dart';
import 'package:cryptography/cryptography.dart' as crypto;

class VaultFactory {
  final AppDatabase _db;
  final KeyDerivationService _kdfService;
  final KeyManagementService _keyManagementService;
  final SecureRandomService _randomService;

  VaultFactory(
    this._db,
    this._kdfService,
    this._keyManagementService,
    this._randomService,
  );

  /// Bootstraps a new vault and returns an active, unlocked session.
  Future<VaultSession> createVault(String masterPassword) async {
    final existingHeaders = await _db.select(_db.vaultHeaders).get();
    if (existingHeaders.isNotEmpty) {
      throw Exception('VaultFactory: A vault already exists in this database.');
    }

    // 1. Generate salt and derive KEK
    final salt = _randomService.generateSalt();
    final kdfResult = await _kdfService.deriveKey(masterPassword, salt: salt);
    final kek = kdfResult['key'] as crypto.SecretKey;
    final argonParams = kdfResult['parameters'] as String;

    // 2. Generate new canonical DEK
    final dek = await _keyManagementService.generateDek();

    // 3. Wrap DEK with KEK
    final wrappedDek = await _keyManagementService.wrapDek(dek, kek);

    // 4. Save to VaultHeaders
    final vaultId = _randomService.generateUuid();
    await _db.into(_db.vaultHeaders).insert(
      VaultHeadersCompanion.insert(
        version: 1,
        createdAt: DateTime.now(),
        vaultId: vaultId,
        cryptoVersion: 1,
        schemaVersion: 1,
        argon2Parameters: argonParams,
        wrappedDEK: wrappedDek,
        checksum: 'todo_checksum', 
      ),
    );

    return VaultSession(
      sessionId: _randomService.generateUuid(),
      dek: dek,
    );
  }
}
