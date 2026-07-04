# Threat Model

A security product must explicitly state what it protects against and what it does not.

## 1. Threats Mitigated

* **Lost or Stolen Device:** Mitigated by Master Password / Biometric lock, AES-256-GCM encryption, and lack of plain-text data on disk.
* **Rooted/Compromised Device (Basic):** Mitigated by active root detection warnings and Keystore-backed key protection. (Note: A deeply compromised OS can eventually bypass user-space protections, but API Vault raises the effort significantly).
* **Memory Inspection:** Mitigated by clearing sensitive variables from memory as quickly as possible and strict zero-logging policies.
* **Screen Capture/Shoulder Surfing:** Mitigated by `FLAG_SECURE` (blocks screenshots/recording) and UI obfuscation of secrets until explicitly revealed.
* **Clipboard Leaks:** Mitigated by auto-clearing the clipboard 30 seconds after a secret is copied.
* **Backup Theft:** Local backups (.vault files) are heavily encrypted. An attacker gaining access to the backup file still requires the Master Password.
* **Brute-Force Attacks:** Mitigated by using Argon2id for key derivation, making brute-forcing computationally expensive and memory-hard against ASICs/GPUs.

## 2. Out of Scope (Currently Not Mitigated)

* **Physical Coercion (Rubber-hose cryptanalysis):** If an attacker forces the user to unlock the device/vault.
* **Supply Chain Attacks on Dependencies:** While we audit dependencies, a compromised Flutter package could theoretically introduce vulnerabilities. (Mitigation: strict minimal dependency policy).
* **Advanced Persistent Threats (APTs) with Kernel-level access:** If a state-sponsored actor has complete, persistent, remote kernel access to the device, local software protections can ultimately be bypassed.
