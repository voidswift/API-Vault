# Dependency Policy

As a security application, we must fear dependencies almost as much as attackers.

## 1. Evaluation Criteria
Before adding ANY third-party package to `pubspec.yaml`, it must answer:

* **Why do we need it?** Can this easily be implemented in-house with < 100 lines of code? If yes, build it.
* **Is it actively maintained?** Check the last commit and release date. Dead projects are security risks.
* **License?** Must be permissive (MIT, Apache 2.0, BSD) and compatible with our open-source release.
* **Security issues?** Check the issue tracker and CVE databases.
* **Can we replace it?** Is the API surface abstracted so we can swap it out if it becomes compromised?

## 2. Approved Core Dependencies (Initial)
* `flutter_riverpod` (State Management)
* `go_router` (Navigation)
* `drift` & `sqlite3_flutter_libs` (Database)
* `cryptography` (Argon2id and AES-GCM implementations)
* `local_auth` (Biometrics)
* `flutter_secure_storage` (Keystore abstraction)

## 3. Ban List
* Generic monolithic toolkits (e.g., GetX) that obscure control flow.
* Any unvetted cryptography library lacking professional audits.
* Analytics/telemetry SDKs (Firebase Analytics, Crashlytics, Mixpanel).
