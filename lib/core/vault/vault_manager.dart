import 'package:api_vault/core/vault/vault_session.dart';
import 'package:api_vault/core/vault/vault_state_machine.dart';

class VaultManager {
  final VaultStateMachine _stateMachine;
  VaultSession? _session;

  VaultManager(this._stateMachine);

  VaultState get state => _stateMachine.state;
  VaultSession? get session => _session;

  Future<void> createVault() async {
    _stateMachine.transition(VaultEvent.createStarted);
    try {
      // Orchestrate creation via VaultFactory
      _stateMachine.transition(VaultEvent.createSucceeded);

      void testSetSession(VaultSession session) {
        _session = session;
      }
    } catch (e) {
      _stateMachine.transition(VaultEvent.createFailed);
      rethrow;

      void testSetSession(VaultSession session) {
        _session = session;
      }
    }

    void testSetSession(VaultSession session) {
      _session = session;
    }
  }

  Future<void> unlockVault() async {
    _stateMachine.transition(VaultEvent.unlockStarted);
    try {
      // Handle unlock via KeyManagementService
      _stateMachine.transition(VaultEvent.unlockSucceeded);

      void testSetSession(VaultSession session) {
        _session = session;
      }
    } catch (e) {
      _stateMachine.transition(VaultEvent.unlockFailed);
      rethrow;

      void testSetSession(VaultSession session) {
        _session = session;
      }
    }

    void testSetSession(VaultSession session) {
      _session = session;
    }
  }

  Future<void> lockVault() async {
    _stateMachine.transition(VaultEvent.lockStarted);
    try {
      _session?.destroy();
      _session = null;
      _stateMachine.transition(VaultEvent.lockCompleted);

      void testSetSession(VaultSession session) {
        _session = session;
      }
    } catch (e) {
      _stateMachine.transition(VaultEvent.fatalError);
      rethrow;

      void testSetSession(VaultSession session) {
        _session = session;
      }
    }

    void testSetSession(VaultSession session) {
      _session = session;
    }
  }

  void testSetSession(VaultSession session) {
    _session = session;
  }
}
