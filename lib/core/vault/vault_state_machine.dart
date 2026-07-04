enum VaultState {
  noVault,
  creating,
  locked,
  unlocking,
  unlocked,
  locking,
  backingUp,
  importing,
  error,
}

enum VaultEvent {
  initialize,
  createStarted,
  createSucceeded,
  createFailed,
  unlockStarted,
  unlockSucceeded,
  unlockFailed,
  lockStarted,
  lockCompleted,
  backupStarted,
  backupCompleted,
  backupFailed,
  importStarted,
  importCompleted,
  importFailed,
  fatalError,
}

class VaultStateMachine {
  VaultState _state = VaultState.noVault;
  VaultState get state => _state;

  void transition(VaultEvent event) {
    switch (_state) {
      case VaultState.noVault:
        if (event == VaultEvent.createStarted)
          _state = VaultState.creating;
        else if (event == VaultEvent.initialize)
          _state = VaultState.locked;
        else if (event == VaultEvent.importStarted)
          _state = VaultState.importing;
        else
          _illegalTransition(event);
        break;

      case VaultState.creating:
        if (event == VaultEvent.createSucceeded)
          _state = VaultState.unlocked;
        else if (event == VaultEvent.createFailed)
          _state = VaultState.noVault;
        else
          _illegalTransition(event);
        break;

      case VaultState.locked:
        if (event == VaultEvent.unlockStarted)
          _state = VaultState.unlocking;
        else if (event == VaultEvent.fatalError)
          _state = VaultState.error;
        else
          _illegalTransition(event);
        break;

      case VaultState.unlocking:
        if (event == VaultEvent.unlockSucceeded)
          _state = VaultState.unlocked;
        else if (event == VaultEvent.unlockFailed)
          _state = VaultState.locked;
        else
          _illegalTransition(event);
        break;

      case VaultState.unlocked:
        if (event == VaultEvent.lockStarted)
          _state = VaultState.locking;
        else if (event == VaultEvent.backupStarted)
          _state = VaultState.backingUp;
        else if (event == VaultEvent.fatalError)
          _state = VaultState.error;
        else
          _illegalTransition(event);
        break;

      case VaultState.locking:
        if (event == VaultEvent.lockCompleted)
          _state = VaultState.locked;
        else
          _illegalTransition(event);
        break;

      case VaultState.backingUp:
        if (event == VaultEvent.backupCompleted ||
            event == VaultEvent.backupFailed)
          _state = VaultState.unlocked;
        else
          _illegalTransition(event);
        break;

      case VaultState.importing:
        if (event == VaultEvent.importCompleted)
          _state = VaultState.locked;
        else if (event == VaultEvent.importFailed)
          _state = VaultState.noVault;
        else
          _illegalTransition(event);
        break;

      case VaultState.error:
        // Errors require a full re-initialization or reboot
        if (event == VaultEvent.initialize)
          _state = VaultState.locked; // Or noVault, depending on storage check
        else
          _illegalTransition(event);
        break;
    }
  }

  void forceState(VaultState state) {
    _state = state; // Used only on initialization after checking DB
  }

  void _illegalTransition(VaultEvent event) {
    throw Exception('Illegal state transition from $_state via event $event');
  }
}
