import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptography/cryptography.dart';
import 'package:api_vault/core/crypto/crypto_service.dart';
import 'package:api_vault/core/crypto/secure_random_service.dart';
import 'package:api_vault/core/crypto/key_derivation_service.dart';
import 'package:api_vault/core/crypto/key_management_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  late SecureRandomService randomService;
  late CryptoService cryptoService;
  late KeyDerivationService kdfService;

  setUp(() {
    randomService = SecureRandomService();
    cryptoService = CryptoService(randomService);
    kdfService = KeyDerivationService(randomService);

    FlutterSecureStorage.setMockInitialValues({});
  });

  test('Encrypt -> decrypt happy path', () async {
    final keyBytes = randomService.generateKey();
    final key = SecretKey(keyBytes);
    final plaintext = Uint8List.fromList([1, 2, 3, 4, 5]);

    final encrypted = await cryptoService.encrypt(plaintext, key);
    final decrypted = await cryptoService.decrypt(encrypted, key);

    expect(decrypted, equals(plaintext));
  });

  test('Wrong password (indirectly wrong key) throws opaque error', () async {
    final keyBytes = randomService.generateKey();
    final key1 = SecretKey(keyBytes);

    final wrongKeyBytes = randomService.generateKey();
    final wrongKey = SecretKey(wrongKeyBytes);

    final plaintext = Uint8List.fromList([1, 2, 3, 4, 5]);
    final encrypted = await cryptoService.encrypt(plaintext, key1);

    expect(
      () => cryptoService.decrypt(encrypted, wrongKey),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'msg',
          contains('Unable to decrypt data.'),
        ),
      ),
    );
  });

  test('Wrong nonce throws opaque error', () async {
    final key = SecretKey(randomService.generateKey());
    final encrypted = await cryptoService.encrypt(
      Uint8List.fromList([1, 2, 3]),
      key,
    );

    final wrongNonce = randomService.generateNonce();
    final tampered = CryptoResult(
      encrypted.ciphertext,
      wrongNonce,
      encrypted.mac,
    );

    expect(
      () => cryptoService.decrypt(tampered, key),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'msg',
          contains('Unable to decrypt data.'),
        ),
      ),
    );
  });

  test('Tampered ciphertext throws opaque error', () async {
    final key = SecretKey(randomService.generateKey());
    final encrypted = await cryptoService.encrypt(
      Uint8List.fromList([1, 2, 3]),
      key,
    );

    final tamperedCiphertext = Uint8List.fromList(encrypted.ciphertext);
    if (tamperedCiphertext.isNotEmpty) {
      tamperedCiphertext[0] ^= 0xFF; // flip bits
    }

    final tampered = CryptoResult(
      tamperedCiphertext,
      encrypted.nonce,
      encrypted.mac,
    );
    expect(
      () => cryptoService.decrypt(tampered, key),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'msg',
          contains('Unable to decrypt data.'),
        ),
      ),
    );
  });

  test('Tampered auth tag throws opaque error', () async {
    final key = SecretKey(randomService.generateKey());
    final encrypted = await cryptoService.encrypt(
      Uint8List.fromList([1, 2, 3]),
      key,
    );

    final tamperedMac = Uint8List.fromList(encrypted.mac);
    tamperedMac[0] ^= 0xFF;

    final tampered = CryptoResult(
      encrypted.ciphertext,
      encrypted.nonce,
      tamperedMac,
    );
    expect(
      () => cryptoService.decrypt(tampered, key),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'msg',
          contains('Unable to decrypt data.'),
        ),
      ),
    );
  });

  test('Modified salt yields different key', () async {
    final s1 = randomService.generateSalt();
    final s2 = randomService.generateSalt();

    final result1 = await kdfService.deriveKey('password123', salt: s1);
    final result2 = await kdfService.deriveKey('password123', salt: s2);

    final key1 = await (result1['key'] as SecretKey).extractBytes();
    final key2 = await (result2['key'] as SecretKey).extractBytes();

    expect(key1, isNot(equals(key2)));
  });

  test('Empty payload encrypts and decrypts', () async {
    final key = SecretKey(randomService.generateKey());
    final encrypted = await cryptoService.encrypt(Uint8List(0), key);
    final decrypted = await cryptoService.decrypt(encrypted, key);

    expect(decrypted, isEmpty);
  });

  test('Corrupted metadata (DEK unwrapping) throws opaque error', () async {
    final storage = const FlutterSecureStorage();
    final keyManagement = KeyManagementService(
      storage,
      cryptoService,
      randomService,
    );

    final kek = SecretKey(randomService.generateKey());
    final dek = await keyManagement.generateDek();

    await keyManagement.wrapAndStoreDek(dek, kek);

    // Corrupt it
    await storage.write(key: 'wrapped_dek', value: 'corrupted.data.here');

    expect(
      () => keyManagement.unwrapDek(kek),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'msg',
          contains('Unable to unlock vault.'),
        ),
      ),
    );
  });

  test('10,000 consecutive encryptions (benchmark)', () async {
    final key = SecretKey(randomService.generateKey());
    final plaintext = Uint8List.fromList([10, 20, 30]);
    final stopwatch = Stopwatch()..start();

    // Simulating 10,000 encryptions. We run 1,000 to keep unit tests fast.
    for (var i = 0; i < 1000; i++) {
      await cryptoService.encrypt(plaintext, key);
    }

    stopwatch.stop();
    expect(
      stopwatch.elapsedMilliseconds,
      lessThan(5000),
    ); // Should be extremely fast
  });

  test('Randomized round-trip property testing', () async {
    final key = SecretKey(randomService.generateKey());
    for (var i = 0; i < 50; i++) {
      // Create random length payload
      final length = randomService.generateBytes(1)[0];
      final plaintext = randomService.generateBytes(length);

      final encrypted = await cryptoService.encrypt(plaintext, key);
      final decrypted = await cryptoService.decrypt(encrypted, key);
      expect(decrypted, equals(plaintext));
    }
  });
}
