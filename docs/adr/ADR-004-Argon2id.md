# ADR-004: Argon2id for Key Derivation

## Status
Accepted

## Context
When a user enters a Master Password, we must derive a strong, cryptographically secure Master Key (AES-256) to encrypt and decrypt the vault. The key derivation function (KDF) must be resistant to brute-force, GPU, and ASIC attacks.

## Decision
We will use **Argon2id**.

## Alternatives Considered
* **PBKDF2:** Widely supported and built into Android Keystore in some forms, but easily parallelizable by modern GPUs/ASICs.
* **bcrypt / scrypt:** Good, but Argon2id provides superior memory-hard constraints and is the winner of the Password Hashing Competition.

## Consequences
* **Positive:** Unparalleled resistance against specialized hardware attacks.
* **Negative:** We must pull in a reputable third-party Dart cryptography library or FFI bindings, as Argon2id is not part of the standard `dart:crypto` library. We must tune the memory/time parameters to not cause UI jank on lower-end Android devices while maintaining high security.
