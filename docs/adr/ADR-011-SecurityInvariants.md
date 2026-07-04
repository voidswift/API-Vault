# ADR 011: Security Invariants

## Context
As API Vault matures, structural guarantees are more important than feature velocity. Security features can degrade through seemingly harmless refactoring. We need an unbreakable list of structural guarantees—invariants—that must remain true at every moment of the application lifecycle.

## Decision
The following Security and Operational Invariants are established. They must be validated in CI/CD, strictly enforced in code review, and backed by automated tests wherever possible.

### Security Invariants

1. **INV-001 (Secrets Are Never Written Unencrypted)**: A secret (payload, name, or metadata) is never written to persistent storage (SQLite, SharedPreferences, File System) in plaintext. It must pass through `VaultCodec`.
2. **INV-002 (Sessions Never Survive a Lock)**: Calling `lock()` guarantees the immediate dereferencing of the Data Encryption Key (DEK). A session object (`VaultSession`) must never survive a lock transition.
3. **INV-003 (Repositories Never Access Plaintext Without SessionGuard)**: DAOs only return encrypted blobs. `VaultRepository` must wrap every single data access in a `SessionGuard.execute()` or `executeAsync()` closure. Repositories cannot self-authorize.
4. **INV-004 (VaultCodec Owns Serialization)**: Repositories must not manipulate bytes, JSON, or encryption structures. `VaultCodec` exclusively handles versioning, packing (ciphertext || mac), and JSON stringification.
5. **INV-005 (Only CryptoService Performs Encryption)**: No other class may instantiate or call AES-GCM or cryptographic primitives directly.
6. **INV-006 (Only VaultManager Changes Lifecycle State)**: State transitions (e.g., from `locked` to `unlocked`) must route exclusively through the centralized `VaultStateMachine` inside `VaultManager`.
7. **INV-007 (Only SecureRandomService Generates Entropy)**: Calls to `dart:math` `Random()` or predictable UUID generators are banned for security parameters.
8. **INV-008 (Logs Never Contain Secrets)**: Audit logs and debug prints must never serialize secret domains (`SecretData`) or keys (`SecretKey`).
9. **INV-009 (Clipboard is Always Temporary)**: Copying a secret to the clipboard must invoke the `ClipboardService`, which enforces an automatic, monotonic-time-based cleanup. Clipboard reads are forbidden.
10. **INV-010 (Backgrounding Leaves Nothing Visible)**: When the app enters a paused/inactive state, the UI must immediately blur or mask. If the background duration exceeds the idle timeout, the `VaultManager` must forcibly transition to `locked`.

### Operational Invariants

1. **INV-011**: A vault is always either Locked or Unlocked.
2. **INV-012**: A DEK belongs to exactly one vault.
3. **INV-013**: A VaultSession belongs to exactly one vault.
4. **INV-014**: A SessionGuard belongs to exactly one session.
5. **INV-015**: Every repository operation executes inside exactly one transaction.
6. **INV-016**: Every transaction produces exactly one audit event (or none if rolled back).
7. **INV-017**: Every unlock produces a new sessionId.
8. **INV-018**: Every lock destroys the previous session forever.

## Review Rules
Every future pull request should answer these five questions:
1. What invariant does this change rely on?
2. What invariant could this change break?
3. What new tests prove it doesn't?
4. Does it introduce a new dependency? Why?
5. Can this be implemented with fewer privileges or less plaintext exposure?
