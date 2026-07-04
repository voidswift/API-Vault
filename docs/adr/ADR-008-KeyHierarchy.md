# ADR 008: Key Hierarchy

## Context
When encrypting user secrets, we need a secure and robust encryption scheme. A naive approach is to use the Master Password to derive an encryption key (via Argon2id) and use that key directly to encrypt all secrets using AES-GCM. 

However, this naive approach introduces significant problems:
1. **Key Rotation Impossible**: If a user changes their Master Password, the derived key changes. Every single secret in the database would need to be decrypted and re-encrypted. If a failure occurs during this massive re-encryption, data corruption is highly likely.
2. **Exposure**: Using the password-derived key for thousands of encryptions increases the risk of key exposure or nonce reuse issues.

## Decision
We will establish a formal **Key Hierarchy** separating the Key Encryption Key (KEK) and the Data Encryption Key (DEK).

```text
Master Password
      ↓
   Argon2id
      ↓
  Master Key (Key Encryption Key)
      ↓
Wrap / Unwrap (using AES-GCM)
      ↓
Data Encryption Key (DEK)
      ↓
  AES-256-GCM
      ↓
   Secrets
```

1. **Master Key (KEK)**: Derived directly from the Master Password using Argon2id. It is NEVER used to encrypt user secrets. It is only used to wrap (encrypt) the DEK.
2. **Data Encryption Key (DEK)**: A randomly generated 32-byte secure key. This DEK is used to encrypt all user secrets. 

## Payload Layout
For AES-GCM encryption, the resulting payload encapsulates the ciphertext and the authentication tag (MAC). We will append the 16-byte MAC tag directly to the end of the ciphertext:

```
Encrypted Payload Structure

+----------------------+------------------+
| Ciphertext (N bytes) | MAC (16 bytes)   |
+----------------------+------------------+
```
We define these constants to avoid magic numbers in the binary processing logic:
- `kGcmTagLength = 16`
- `kNonceLength = 12`
- `kKeyLength = 32`

## Consequences
### Positive
* **Instant Password Changes**: Changing a Master Password only requires re-wrapping the DEK. We don't need to touch the secrets table at all.
* **Security Isolation**: The password-derived key is only used for one encryption operation (wrapping the DEK).
* **Robust Serialization**: Storing the MAC alongside the ciphertext avoids database schema issues.

### Negative
* Increased architectural complexity.
