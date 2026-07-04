# Data Flow Architecture

To ensure security, data must strictly flow through designated layers. Nothing bypasses the encryption layer.

## The Standard Pipeline

```text
User Interaction (Tap "Save Secret")
        │
        ▼
UI Layer (Flutter Widget)
        │
        ▼
State Management (Riverpod Notifier)
        │
        ▼
Domain Layer (Use Case / Business Logic validation)
        │
        ▼
Repository Layer (SecretRepository - Prepares DB Models)
        │
        ▼
Encryption Layer (CryptoService - AES-256-GCM Encrypts the payload)
        │
        ▼
Database Access Object (Drift DAO)
        │
        ▼
SQLite Database (Storage on disk)
```

## Critical Rules
1. **Never pass plain text entities directly to the DAO.** The Repository MUST route data through the Encryption Layer first.
2. **Never expose the AES Master Key to the UI.** The Key remains strictly within the CryptoService and memory boundaries configured for key management.
3. **Wipe memory:** Once encryption is complete, sensitive variables containing plain-text keys or data should be aggressively cleared from memory where possible within Dart's garbage collection constraints.
