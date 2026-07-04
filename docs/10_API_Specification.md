# API Specification (Internal Services)

Even though API Vault is offline, all internal services must have strict, well-defined contracts.

## 1. VaultService
Handles the core business logic of the vault.
* `createVault(String masterPassword): Future<void>`
* `unlockVault(String masterPassword): Future<bool>`
* `lockVault(): Future<void>`
* `changeMasterPassword(String oldPassword, String newPassword): Future<void>`
* `exportVault(String path): Future<void>`
* `importVault(String path, String password): Future<void>`
* `isVaultLocked(): bool`

## 2. CryptoService
Handles all cryptographic operations. No other service should implement cryptography.
* `encrypt(Uint8List data, Uint8List key, Uint8List nonce): Future<Uint8List>`
* `decrypt(Uint8List encryptedData, Uint8List key, Uint8List nonce): Future<Uint8List>`
* `deriveKey(String password, Uint8List salt): Future<Uint8List>` (Argon2id implementation)
* `generateNonce(int length): Uint8List`
* `generateSecureRandomBytes(int length): Uint8List`

## 3. BiometricService
Handles interactions with the Android BiometricPrompt and Hardware Keystore.
* `authenticate(String reason): Future<bool>`
* `isAvailable(): Future<bool>`
* `getStatus(): Future<BiometricStatus>`
* `storeMasterKey(Uint8List key): Future<void>`
* `retrieveMasterKey(): Future<Uint8List>`

## 4. SecretRepository
Abstracts database access for secrets.
* `addSecret(Secret item): Future<void>`
* `updateSecret(Secret item): Future<void>`
* `deleteSecret(String id): Future<void>`
* `getSecret(String id): Future<Secret>`
* `getAllSecrets(): Future<List<Secret>>`
