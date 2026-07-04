import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'secure_random_service.dart';

class CryptoResult {
  final Uint8List ciphertext;
  final Uint8List nonce;
  final Uint8List mac;
  CryptoResult(this.ciphertext, this.nonce, this.mac);
}

class CryptoService {
  final AesGcm _cipher = AesGcm.with256bits();
  final SecureRandomService _randomService;
  CryptoService(this._randomService);

  Future<CryptoResult> encrypt(Uint8List plaintext, SecretKey key) async {
    try {
      final nonce = _randomService.generateNonce();
      final box = await _cipher.encrypt(
        plaintext,
        secretKey: key,
        nonce: nonce,
      );
      return CryptoResult(
        Uint8List.fromList(box.cipherText),
        Uint8List.fromList(nonce),
        Uint8List.fromList(box.mac.bytes),
      );
    } finally {
      // We don't clear plaintext here because dart doesn't let us guarantee where it came from, but we encourage clearing the original buffer.
    }
  }

  Future<Uint8List> decrypt(CryptoResult encrypted, SecretKey key) async {
    try {
      final box = SecretBox(
        encrypted.ciphertext,
        nonce: encrypted.nonce,
        mac: Mac(encrypted.mac),
      );
      final plaintext = await _cipher.decrypt(box, secretKey: key);
      return Uint8List.fromList(plaintext);
    } catch (e) {
      throw Exception('Unable to decrypt data.');
    }
  }
}
