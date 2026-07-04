# Threats Not Addressed

API Vault is designed to protect secrets against data extraction from a lost, stolen, or logically compromised device, provided the vault is locked. It does **not** protect against all possible attacks. A mature security product must be explicit about its limitations.

The following threats are **explicitly out of scope** for this application's threat model:

1. **Rooted/Jailbroken Environments**: If the operating system is compromised or rooted, the OS sandbox is bypassed. An attacker with root access can dump memory, extract the Data Encryption Key (DEK) while the vault is unlocked, or hook the application's runtime.
2. **Kernel Compromises**: Similar to root, kernel-level attacks bypass all user-space protections.
3. **Malicious Keyboards / Keyloggers**: If the user has installed a compromised custom keyboard, their master password can be intercepted during entry.
4. **Hardware Keyloggers**: Physical interception of input devices (e.g., Bluetooth keyboards) is not mitigated.
5. **Shoulder Surfing / Screen Recording**: If an attacker observes the screen (physically or via malicious screen recording apps), plaintext secrets displayed on screen are compromised. (Note: API Vault will mask screens when backgrounded, but cannot prevent active foreground recording without OS-level `FLAG_SECURE`, which may still be bypassed by root).
6. **Malicious Accessibility Services**: On Android, excessive accessibility permissions granted to malicious apps can read screen content.
7. **Weak Master Passwords**: Argon2id provides significant resistance to brute forcing, but if a user chooses an incredibly weak password (e.g., "1234"), no KDF can fully protect them against a targeted offline dictionary attack if the `.vault` file is exfiltrated.
8. **Compromised OS Keystore (Hardware Vulnerabilities)**: If a vulnerability exists in the device's Trusted Execution Environment (TEE) or Secure Enclave (e.g., extracting biometric-wrapped keys without user interaction), Mode B (Biometric) unlocking could be compromised.

API Vault's guarantees apply only as long as the underlying operating system and hardware function as designed.
