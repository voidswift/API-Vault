# ADR 010: Recovery Strategy

## Context
API Vault heavily leverages Android Keystore / iOS Keychain to store the wrapped Data Encryption Key (DEK). This facilitates features like biometric unlock. However, OS keystores can be cleared by the system (e.g., if a user removes their device lock screen PIN, or due to a device migration/backup restore). If the wrapped DEK is ONLY stored in the keystore, clearing the keystore permanently destroys the vault, even if the user knows their Master Password.

## Decision
We must decouple the vault's survival from the OS Keystore. We introduce a `VaultHeader` concept. The `VaultHeader` is an authoritative, overarching metadata structure for the entire vault.

We explicitly define **two unlock modes**.

```text
Mode A: Password Unlock

Master Password
      ↓
Argon2id
      ↓
Master Key
      ↓
Unwrap DEK from VaultHeaders
```

```text
Mode B: Biometric Unlock

Hardware Keystore
      ↓
Retrieve wrapped DEK
      ↓
Session
```

The most important invariant of this design is:
> **There is exactly one canonical DEK. There may be multiple wrapping mechanisms, but never multiple DEKs.**

When a user enables Biometrics, we store a *second* wrapped copy of the DEK in the OS Keystore (wrapped by a hardware-backed biometric key). However, the primary `wrappedDEK`—wrapped by the user's Master Password—is ALWAYS stored in the `VaultHeader` in the SQLite database itself.

## Consequences
### Positive
* **Device Migration**: A `.vault` export file contains the SQLite database, which includes the `VaultHeader`. A user can migrate devices seamlessly.
* **Resilience**: If the Android Keystore is wiped, the user falls back to their Master Password. The vault is never lost.

### Negative
* We must carefully manage two wrapped DEKs if biometrics are enabled (one wrapped by Master Password, one by Hardware Key).
