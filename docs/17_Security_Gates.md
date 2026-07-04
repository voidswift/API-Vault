# Security Gates Checklist

No pull request can be merged, and no feature is considered "done", unless this checklist passes. 

* [ ] Secrets are never logged to the console (not even in debug mode).
* [ ] Clipboard auto-clear is supported and verified working (30-second expiry).
* [ ] Screenshots and screen recording are disabled (`FLAG_SECURE`) on all screens containing sensitive data.
* [ ] Root detection is integrated and actively warns the user.
* [ ] Vault auto-lock triggers successfully upon backgrounding/timeout.
* [ ] Master key is NEVER persisted to disk in plain text.
* [ ] Memory is aggressively cleared/overwritten after unlock (where possible within Dart boundaries).
* [ ] Unit tests and Cryptography round-trip tests pass 100%.
* [ ] CI Pipeline passes with zero warnings (`flutter analyze --fatal-warnings`).
* [ ] Architecture boundaries are respected (e.g., UI does not call CryptoService directly).
