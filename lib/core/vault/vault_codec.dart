import 'dart:convert';
import 'dart:typed_data';
import 'package:api_vault/core/crypto/crypto_service.dart';
import 'package:api_vault/core/vault/models/secret_data.dart';
import 'package:cryptography/cryptography.dart';

const int kGcmTagLength = 16;
const int kNonceLength = 12;

class EncodedVaultItem {
  final Uint8List encryptedPayload; // Ciphertext || MAC
  final Uint8List nonce;
  final int algorithmVersion;

  EncodedVaultItem({
    required this.encryptedPayload,
    required this.nonce,
    required this.algorithmVersion,
  });
}

class VaultCodec {
  final CryptoService _cryptoService;

  VaultCodec(this._cryptoService);

  Future<EncodedVaultItem> encode(SecretData data, SecretKey dek) async {
    final jsonString = jsonEncode(data.toJson());
    final plaintext = Uint8List.fromList(utf8.encode(jsonString));
    
    final cryptoResult = await _cryptoService.encrypt(plaintext, dek);
    
    // Pack ciphertext || mac
    final packed = BytesBuilder(copy: false)
      ..add(cryptoResult.ciphertext)
      ..add(cryptoResult.mac);
      
    return EncodedVaultItem(
      encryptedPayload: packed.toBytes(),
      nonce: cryptoResult.nonce,
      algorithmVersion: 1, // Future proofing
    );
  }

  Future<SecretData> decode(Uint8List encryptedPayload, Uint8List nonce, SecretKey dek) async {
    if (encryptedPayload.length < kGcmTagLength) {
      throw Exception('Invalid payload length');
    }

    final ciphertextLength = encryptedPayload.length - kGcmTagLength;
    final ciphertext = encryptedPayload.sublist(0, ciphertextLength);
    final mac = encryptedPayload.sublist(ciphertextLength);

    final cryptoResult = CryptoResult(ciphertext, nonce, mac);
    final decryptedBytes = await _cryptoService.decrypt(cryptoResult, dek);
    
    final jsonString = utf8.decode(decryptedBytes);
    final Map<String, dynamic> json = jsonDecode(jsonString);
    
    return SecretData.fromJson(json);
  }
}
