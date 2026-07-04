import 'package:api_vault/core/vault/vault_session.dart';

class SessionGuard {
  final VaultSession? _session;

  SessionGuard(this._session);

  T execute<T>(T Function(VaultSession session, String operationId) action) {
    if (_session == null || !_session!.isUnlocked) {
      throw Exception('SessionGuard: Vault is locked or no session exists.');
    }
    final operationId = _session!.beginOperation();
    return action(_session!, operationId);
  }

  Future<T> executeAsync<T>(Future<T> Function(VaultSession session, String operationId) action) async {
    if (_session == null || !_session!.isUnlocked) {
      throw Exception('SessionGuard: Vault is locked or no session exists.');
    }
    final operationId = _session!.beginOperation();
    return await action(_session!, operationId);
  }
}
