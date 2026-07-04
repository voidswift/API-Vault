# Security Assumptions

No security system exists in a vacuum. The guarantees provided by API Vault (documented in `Verification_Report.md`) rely on the following external assumptions. If any of these assumptions are violated by the operating environment, the vault's security guarantees may degrade.

1. **OS Keystore Integrity**: Android Keystore / iOS Keychain correctly protects hardware-backed keys when available, and their implementations are not compromised.
2. **Cryptographic Primitives**: The `cryptography` package correctly implements AES-256-GCM, and the underlying OS/hardware provides secure execution.
3. **Argon2id Specification**: The Argon2id implementation matches its specification and provides the expected resistance to GPU/ASIC cracking attacks.
4. **Application Sandboxing**: The operating system (Android/iOS) strictly enforces application sandboxing, preventing other applications (without root/jailbreak privileges) from reading API Vault's memory or private storage space.
5. **Memory Management**: Device memory may still contain immutable copies of secrets beyond our direct control (e.g., inside the Dart managed runtime garbage collector, or OS swap files if enabled).
6. **Device Root/Jailbreak**: Rooted or jailbroken devices reduce security guarantees. A compromised OS can bypass sandboxing, dump memory, and intercept inputs, despite our mitigations.
7. **Secure Entropy**: The operating system's PRNG (Pseudo-Random Number Generator) provides cryptographically secure entropy.
8. **Time Monotonicity**: `Stopwatch` provides reliable, monotonic time progression that is immune to wall-clock manipulation by the user.
