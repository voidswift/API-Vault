# ADR-006: Offline-First Architecture

## Status
Accepted

## Context
A developer vault app deals with extremely sensitive production credentials. Adding a cloud backend immediately increases the attack surface, introduces account management complexity, requires managing sync conflicts, and fundamentally changes the trust model.

## Decision
API Vault will be **100% Offline-First (and currently Offline-Only)** for the MVP. No telemetry, no Firebase, no backend database.

## Alternatives Considered
* **Firebase / Supabase backend:** Would allow quick multi-device sync but breaks the zero-knowledge / privacy-by-default requirement for a v1.0 release.

## Consequences
* **Positive:** Massive reduction in attack surface. Simplifies the privacy policy to "We don't collect anything." Instantly builds trust with security professionals.
* **Negative:** Users cannot sync between their phone and desktop out of the box. They must rely on manual encrypted `.vault` exports/imports until Phase 4 (where we build E2E encrypted sync).
