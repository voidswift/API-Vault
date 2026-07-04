# ADR-005: AES-256-GCM for Data Encryption

## Status
Accepted

## Context
We need a symmetric encryption algorithm to encrypt the secrets stored in the SQLite database. 

## Decision
We will use **AES-256 in GCM (Galois/Counter Mode)**.

## Alternatives Considered
* **AES-256-CBC (Cipher Block Chaining):** Requires manual MAC (Message Authentication Code) implementation (e.g., HMAC-SHA256) to prevent padding oracle attacks and ensure ciphertext integrity. It's easy to implement incorrectly.
* **ChaCha20-Poly1305:** Excellent performance on devices without hardware AES acceleration, but AES-256-GCM is standard, widely supported, and often hardware-accelerated on modern Android devices.

## Consequences
* **Positive:** Authenticated encryption. GCM provides both confidentiality and integrity/authenticity. Any modification to the encrypted database will throw an authentication error instead of decrypting garbage data.
* **Negative:** GCM requires a unique Nonce for EVERY encryption operation under the same key. We must ensure our Nonce generation is robust and never repeats.
