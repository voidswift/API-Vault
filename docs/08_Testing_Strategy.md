# Testing Strategy

Given the security-critical nature of API Vault, testing must be rigorous and automated.

## 1. Unit Testing
* **Target Coverage:** > 80% overall, 100% in `core/security` and `core/encryption`.
* **Focus Areas:**
  * Encryption/Decryption round-trips.
  * Key derivation logic (Argon2id).
  * Validation logic (Password strength, JWT parsing).
  * State management (Riverpod providers) logic.

## 2. Widget Testing
* **Focus Areas:**
  * Auth screens (ensuring proper state transitions on unlock/fail).
  * Vault list interactions (swiping, tapping).
  * Clipboard clearing feedback (SnackBar verification).
  * Obfuscation toggles (ensuring secrets are hidden by default).

## 3. Integration & E2E Testing (Flutter Integration Test)
* **Focus Areas:**
  * Full user journey: Onboard -> Set Password -> Add Secret -> Lock App -> Unlock via Biometrics -> View Secret.
  * Backup & Restore pipeline validation.
  * Database migration testing (crucial for future updates).

## 4. Security & Penetration Testing
* **Static Analysis:** Strict Dart linting and dependency auditing (`dart pub outdated`, checking for CVEs in cryptography packages).
* **Dynamic Analysis:** 
  * Running the app on a rooted emulator to verify root detection.
  * Attempting to memory dump the emulator to verify no plain-text keys exist.
  * Attempting to extract the SQLite DB and manually decrypting it.

## 5. CI/CD Pipeline
* GitHub Actions to run:
  1. `flutter analyze`
  2. `flutter test` (Unit & Widget)
  3. Security dependency audit.
  4. Build APK (Signed only for specific release branches).
