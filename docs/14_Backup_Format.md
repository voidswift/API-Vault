# Backup Format (.vault)

The backup file must be highly structured and versioned to ensure future compatibility. It will be an encrypted binary or highly structured JSON payload encoded in Base64.

## File Structure

```text
.vault File
│
├── Header (Magic bytes to identify file type, e.g., "APIV")
│
├── Version (e.g., 0x01)
│
├── Salt (Argon2id salt used during export)
│
├── Nonce (AES-256-GCM nonce for the encrypted payload)
│
├── Encrypted Database (The exported SQLite DB or JSON representation)
│
├── Authentication Tag (GCM Auth Tag for integrity verification)
│
└── Checksum (SHA-256 hash of the above fields for basic file corruption detection)
```

## Import/Export Rules
1. The `.vault` file is encrypted using a password chosen by the user AT THE TIME OF EXPORT (may or may not be the Master Password).
2. The export process derives a temporary AES-256-GCM key using Argon2id and the provided password + randomly generated Salt.
3. Import verifies the Checksum and Authentication Tag before attempting to parse the database payload.
