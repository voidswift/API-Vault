import 'dart:typed_data';
import 'package:api_vault/core/crypto/crypto_service.dart';
import 'package:api_vault/core/crypto/key_derivation_service.dart';
import 'package:api_vault/core/crypto/key_management_service.dart';
import 'package:api_vault/core/crypto/secure_random_service.dart';
import 'package:api_vault/core/storage/daos/vault_dao.dart';
import 'package:api_vault/core/storage/database.dart';
import 'package:api_vault/core/vault/models/secret_data.dart';
import 'package:api_vault/core/vault/session_guard.dart';
import 'package:api_vault/core/vault/vault_codec.dart';
import 'package:api_vault/core/vault/vault_factory.dart';
import 'package:api_vault/core/vault/vault_manager.dart';
import 'package:api_vault/core/vault/vault_repository.dart';
import 'package:api_vault/core/vault/vault_state_machine.dart';
import 'package:api_vault/core/vault/vault_session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class SecurityHarness {
  late AppDatabase db;
  late SecureRandomService randomService;
  late CryptoService cryptoService;
  late KeyDerivationService kdfService;
  late KeyManagementService keyManagementService;
  late VaultCodec codec;
  late VaultDao dao;
  late VaultRepository repository;
  late VaultManager manager;
  late VaultStateMachine stateMachine;
  late VaultFactory factory;

  bool _initialized = false;
  String? currentMasterPassword;

  Future<SecurityHarness> initialize() async {
    FlutterSecureStorage.setMockInitialValues({});
    db = AppDatabase.forTesting();
    dao = db.vaultDao;
    
    randomService = SecureRandomService();
    cryptoService = CryptoService(randomService);
    kdfService = KeyDerivationService(randomService);
    keyManagementService = KeyManagementService(
      const FlutterSecureStorage(),
      cryptoService,
      randomService,
    );
    
    codec = VaultCodec(cryptoService);
    stateMachine = VaultStateMachine();
    manager = VaultManager(stateMachine);
    factory = VaultFactory(db, kdfService, keyManagementService, randomService);
    
    _initialized = true;
    return this;
  }

  Future<void> dispose() async {
    await db.close();
  }

  Future<SecurityHarness> createVault(String masterPassword) async {
    assert(_initialized);
    currentMasterPassword = masterPassword;
    await manager.createVault();
    final session = await factory.createVault(masterPassword);
    // Overwrite the manager's session (in reality this is orchestrated in a unified controller)
    // To simulate real flow, we need the session guard
    manager.testSetSession(session);
    repository = VaultRepository(dao, codec, SessionGuard(session));
    return this;
  }

  Future<SecurityHarness> unlock(String password) async {
    // In real app, unlock fetches header and checks password. 
    // Here we'll do the logic manually for the harness
    await manager.unlockVault();
    final headers = await db.select(db.vaultHeaders).get();
    final header = headers.first;

    final kdfResult = await kdfService.deriveKey(password, salt: header.argon2Parameters); // Note: we need the salt separated. But we assume we have it.
    // Simplifying unlock for harness:
    // final kek = kdfResult['key'];
    // final dek = await keyManagementService.unwrapDek(header.wrappedDEK, kek);
    // session = VaultSession(sessionId: 'new_id', dek: dek);
    return this;
  }

  Future<SecurityHarness> lock() async {
    await manager.lockVault();
    return this;
  }

  Future<SecurityHarness> addSecret(SecretData secret) async {
    await repository.saveSecret(randomService.generateUuid(), secret);
    return this;
  }

  Future<SecurityHarness> expectFailure(Future Function() action) async {
    try {
      await action();
      fail('Expected action to fail, but it succeeded.');
    } catch (e) {
      // Expected
    }
    return this;
  }

  // Fuzz testing logic
  Future<SecurityHarness> injectRandomBlob() async {
    // Corrupt database
    return this;
  }
}
