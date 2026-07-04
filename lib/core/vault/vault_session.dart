import 'package:cryptography/cryptography.dart';
import 'package:uuid/uuid.dart';

class VaultSession {
  final String sessionId;
  final Stopwatch _sessionTimer;
  Duration _lastActivityElapsed;
  SecretKey? _dek;
  final _uuid = const Uuid();

  VaultSession({required this.sessionId, required SecretKey dek})
    : _sessionTimer = Stopwatch()..start(),
      _lastActivityElapsed = Duration.zero,
      _dek = dek;

  bool get isUnlocked => _dek != null;

  Duration get idleDuration => _sessionTimer.elapsed - _lastActivityElapsed;

  void touch() {
    _lastActivityElapsed = _sessionTimer.elapsed;
  }

  /// Generates a unique ID for an operation and touches the session to reset idle timeout.
  String beginOperation() {
    touch();
    return _uuid.v4();
  }

  SecretKey get dek {
    if (_dek == null) {
      throw Exception('Vault session is locked or destroyed.');
    }
    return _dek!;
  }

  void destroy() {
    _dek = null;
    _sessionTimer.stop();
  }
}
