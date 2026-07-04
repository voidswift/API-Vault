import 'dart:math';
import 'dart:typed_data';
class SecureRandomService {
  final Random _random = Random.secure();

  Uint8List generateBytes(int length) {
    final bytes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  Uint8List generateNonce([int length = 12]) => generateBytes(length);
  Uint8List generateSalt([int length = 16]) => generateBytes(length);
  Uint8List generateKey([int length = 32]) => generateBytes(length);
}
