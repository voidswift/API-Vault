# Development Roadmap

## Phase 0: Planning & Architecture (Current)
* [x] Define PRD & North Star Vision
* [x] Establish Security Architecture & Threat Model
* [x] Design Database Schema
* [x] Define System Architecture (Clean Architecture)
* [x] Sketch UI/UX Flows

## Phase 1: Foundation & Vault Core
* **Repo Setup:** `flutter create`, Riverpod, GoRouter, Drift, linting.
* **Security Core:** Implement Argon2id, AES-256-GCM, and Android Keystore integration.
* **Database Core:** Setup SQLite tables and DAOs.
* **Auth UI:** Onboarding, Master Password creation, Biometric unlock.
* **Vault UI:** Add, Edit, View, and Delete secrets. Categories setup.

## Phase 2: UX Polish & Security Health
* **Search & Filtering:** Global search implementation.
* **Security Health Dashboard:** Logic for detecting expiring keys, weak passwords, and root detection warnings.
* **Backup/Restore:** Implement encrypted `.vault` export/import.
* **Auto-Lock & Clipboard:** Implement lifecycle observers for auto-lock and clipboard clearing.

## Phase 3: Developer Power Tools
* **JWT Toolkit:** Decode, Verify, Generate.
* **API Tester:** Mini-Postman client implementation.
* **Generators:** UI and logic for cryptographic key generation.
* **Code Snippets:** Generate integration snippets (Python, JS, Go, etc.) for stored secrets.

## Phase 4: Future / Premium Additions
* Encrypted Cloud Sync (E2E)
* Team Vaults
* Desktop & iOS ports
* GitHub Secrets Integration
