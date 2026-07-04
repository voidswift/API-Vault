# Security Architecture

## 1. Core Principles
* **Zero-knowledge architecture:** The app cannot decrypt data without the user's Master Password or Biometrics.
* **No Plain Text:** No plain text secrets ever touch the disk.
* **Privacy by Default:** Offline only, no telemetry, no cloud sync for the MVP.

## 2. Encryption Flow
* **Algorithm:** AES-256-GCM (Provides both encryption and integrity protection. Avoids CBC mode vulnerabilities).
* **Key Derivation:** Argon2id (Modern recommendation, resistant to GPU and ASIC attacks).

```text
Master Password
        │
        ▼
Argon2id (Key Derivation Function)
        │
        ▼
AES-256-GCM Master Key (Symmetric Key)
        │
        ▼
Encrypt/Decrypt Secrets
        │
        ▼
SQLite Database (Stored Encrypted)
```

## 3. Key Storage
* The Master Key (or the hash used to verify the Master Password) is never stored directly in the database.
* When Biometrics are enabled, a high-entropy key is generated, encrypted by the Android Hardware Keystore (TEE/Secure Enclave), and stored locally. Biometric auth decrypts this key to unlock the vault.

## 4. App Security Features
* **Auto Lock:** Configurable timers (1 min, 5 min, 15 min, Immediate).
* **Screen Privacy:** `FLAG_SECURE` on Android to prevent screenshots and screen recording.
* **Root/Jailbreak Detection:** Warn users or prevent app launch on compromised devices.
* **Clipboard Clearing:** Automatically clear copied secrets after 30 seconds.

## 5. Strict Logging Policy
Never log the following, even in debug mode:
* API keys
* Tokens
* Passwords
* Secrets
* JWT contents
* Encryption keys
