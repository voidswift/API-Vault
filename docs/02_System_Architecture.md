# System Architecture

## 1. Technology Stack
* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Riverpod
* **Navigation:** GoRouter
* **Local Database:** SQLite via Drift ORM (Type-safe, handles migrations excellently)
* **Dependency Injection:** Handled natively by Riverpod (No GetIt)

## 2. Architectural Pattern
Feature-first + Clean Architecture to ensure scalability and separation of concerns.

### Data Flow Pipeline
```
Feature UI (Widgets & Providers)
        │
        ▼
Domain Layer (Models & Business Logic)
        │
        ▼
Repository Layer (Abstract Data Access)
        │
        ▼
Local Database (SQLite / Drift)
        │
        ▼
Encryption Layer (Argon2id + AES-256-GCM)
        │
        ▼
Android Keystore (Secure Enclave Key Management)
```

## 3. Folder Structure
A highly scalable, feature-first structure:

```text
lib/
│
├── app/
│   ├── app.dart
│   ├── router/
│   ├── theme/
│   └── config/
│
├── core/
│   ├── encryption/
│   ├── storage/
│   ├── security/
│   ├── utils/
│   ├── constants/
│   ├── exceptions/
│   └── services/
│
├── features/
│   ├── vault/
│   ├── auth/
│   ├── generator/
│   ├── api_tester/
│   ├── jwt/
│   ├── backup/
│   ├── settings/
│   ├── health_dashboard/
│   └── onboarding/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   ├── extensions/
│   └── providers/
│
└── main.dart
```
