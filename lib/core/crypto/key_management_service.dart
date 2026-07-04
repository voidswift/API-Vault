import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cryptography/cryptography.dart';
import 'crypto_service.dart';
import 'secure_random_service.dart';

class KeyManagementService {
  final FlutterSecureStorage _secureStorage;
  final CryptoService _cryptoService;
  final SecureRandomService _randomService;
  KeyManagementService(
    this._secureStorage,
    this._cryptoService,
    this._randomService,
  );

  Future<SecretKey> generateDek() async {
    final bytes = _randomService.generateKey();
    return SecretKey(bytes);
  }

  Future<String> wrapDek(SecretKey dek, SecretKey kek) async {
    final dekBytes = Uint8List.fromList(await dek.extractBytes());
    final result = await _cryptoService.encrypt(dekBytes, kek);
    return '${base64Encode(result.ciphertext)}.${base64Encode(result.nonce)}.${base64Encode(result.mac)}';
  }

  Future<SecretKey> unwrapDek(String payload, SecretKey kek) async {
    final parts = payload.split('.');
    if (parts.length != 3) throw Exception('Unable to unlock vault.');
    try {
      final ciphertext = base64Decode(parts[0]);
      final nonce = base64Decode(parts[1]);
      final mac = base64Decode(parts[2]);
      final dekBytes = await _cryptoService.decrypt(
        CryptoResult(ciphertext, nonce, mac),
        kek,
      );
      return SecretKey(dekBytes);
    } catch (_) {
      throw Exception('Unable to unlock vault.');
    }
  }

  Future<void> wrapAndStoreDekBiometric(
    SecretKey dek,
    SecretKey hardwareKek,
  ) async {
    final payload = await wrapDek(dek, hardwareKek);
    await _secureStorage.write(key: 'wrapped_dek_biometric', value: payload);
  }

  Future<SecretKey> unwrapDekBiometric(SecretKey hardwareKek) async {
    final payload = await _secureStorage.read(key: 'wrapped_dek_biometric');
    if (payload == null)
      throw Exception('Unable to unlock vault (biometric absent).');
    return unwrapDek(payload, hardwareKek);
  }
}
