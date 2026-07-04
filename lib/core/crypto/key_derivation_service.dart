import 'dart:typed_data';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'secure_random_service.dart';

class KeyDerivationService {
  final SecureRandomService _randomService;
  KeyDerivationService(this._randomService);

  Future<Map<String, dynamic>> deriveKey(
    String password, {
    Uint8List? salt,
  }) async {
    final s = salt ?? _randomService.generateSalt();
    final kdf = Argon2id(
      memory: 65536,
      iterations: 3,
      parallelism: 4,
      hashLength: 32,
    );
    final derivedKey = await kdf.deriveKeyFromPassword(
      password: password,
      nonce: s,
    );
    final keyBytes = await derivedKey.extractBytes();
    return {
      'key': SecretKey(keyBytes),
      'salt': s,
      'params': {'m': 65536, 't': 3, 'p': 4, 'salt': base64Encode(s)},
    };
  }
}
