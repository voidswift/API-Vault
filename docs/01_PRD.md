# Product Requirements Document (PRD): API Vault

## 1. Vision & Purpose
**North Star Vision:** 
> *"API Vault is an offline-first, open-source Developer Security Hub that securely stores secrets, manages API credentials, provides cryptographic utilities, and offers essential developer security tools, all protected by modern encryption and designed with privacy by default."*

API Vault acts as a 1Password + Postman + Secret Manager + Developer Toolkit. It prevents the common mistake of storing API keys in `.env` files by providing a robust, highly secure, and feature-rich local hub for all developer secrets and tools.

## 2. Target Audience
* **Primary:** Software Developers, DevOps Engineers, Cybersecurity Professionals, Students learning APIs, Freelancers, Indie Hackers.
* **Secondary:** Tech-savvy individuals needing secure local storage for digital assets.

## 3. Pricing & Distribution Strategy
* **MVP:** 100% Free, Offline-first, No account required, No telemetry.
* **Open Source:** Core open-source (Apache 2.0 or MIT) to build and maintain trust.
* **Future Premium (Phase 4+):** Encrypted cloud sync, team vaults, secret sharing, multiple vaults, enterprise policies, hardware security key support.

## 4. Platform Characteristics
* **Offline Only (MVP):** No backend, No Firebase, No Supabase. Everything stays on the device.
* **Platform:** Android MVP (iOS & Desktop later via Flutter).
* **Minimum Android SDK:** `minSdk = 26` (Android 8.0 Oreo) - chosen for superior Keystore, biometric, and cryptography APIs.

## 5. Feature Priorities
### Core (Phase 1 & 2)
* Local Encrypted Vault (No plain text secrets)
* AES-256-GCM Encryption & Argon2id Key Derivation
* Master Password & Biometric Unlock
* Search & Categories
* Encrypted Backup (.vault file) & Restore

### Power Tools (Phase 3)
* JWT Decoder, Verifier, Generator
* API Request Tester (mini-Postman)
* Cryptographic Key Generator (UUID, RSA, AES, etc.)
* SDK Code Snippets

### Security Health Dashboard (New Feature)
* Active security companion displaying expiring keys, weak secrets, duplicate keys, unused secrets, recently accessed items, backup status, root detection warnings, biometric status, and clipboard auto-clear status.

### Future (Phase 4)
* Cloud Sync (E2E Encrypted)
* Team Vaults & Secret Sharing
* GitHub Integration & Secret Rotation
* AI Debugging Assistant
