# Error Handling Strategy

Generic "Something went wrong" errors are unacceptable in a security context. Every exception must be categorized, logged (if safe), and clearly communicated to the user (without leaking sensitive data).

## Error Categories

### 1. Authentication
* `MasterPasswordIncorrectException`
* `BiometricLockoutException`
* `AuthenticationTimeoutException`

### 2. Encryption
* `EncryptionFailedException`
* `DecryptionFailedException` (Could mean data corruption or wrong key)
* `IntegrityCheckFailedException` (GCM Auth Tag mismatch)

### 3. Database
* `DatabaseInitializationException`
* `ConstraintViolationException`
* `MigrationFailedException`

### 4. Import/Export
* `BackupFileCorruptedException`
* `InvalidBackupVersionException`
* `ExportPermissionDeniedException`

### 5. Validation
* `WeakPasswordException`
* `InvalidSecretFormatException`
* `JwtParsingException`

## Rules for UI Display
* Never display stack traces or raw exception strings to the user.
* Map domain exceptions to user-friendly localization strings.
* E.g., `DecryptionFailedException` -> "Failed to unlock secret. The data may be corrupted or the key is invalid."
