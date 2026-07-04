# Release Plan

## Alpha (Internal / F&F)
* **Goal:** Verify core encryption, UI flow, and database stability on diverse real hardware.
* **Scope:** Phase 1 features only.
* **Distribution:** Manual APK distribution or Firebase App Distribution (solely for distribution, no analytics integrated into the app itself).

## Beta (Public via Play Store - Early Access)
* **Goal:** Test offline backup workflows, Biometric integration across various Android OEM implementations, and gather feedback on Power Tools.
* **Scope:** Phase 1 & 2, partial Phase 3.
* **Security:** Perform a professional or community security audit on the GitHub repository before the Beta launch.

## 1.0 General Availability (GA)
* **Goal:** Stable, trusted Developer Security Hub.
* **Marketing Focus:** "The Offline-First Developer Vault."
* **Release Artifacts:**
  * Google Play Store listing.
  * F-Droid release (critical for the privacy/offline community).
  * GitHub Releases (direct APK downloads with SHA-256 checksums).

## Post-Launch
* **Bi-Weekly Updates:** Focus on expanding Power Tools (JWT features, API tester improvements).
* **Vulnerability Disclosure Program:** Establish a `SECURITY.md` in the repo to handle responsible disclosures.
