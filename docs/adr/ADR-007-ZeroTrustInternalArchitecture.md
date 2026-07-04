# ADR-007: Zero Trust Internal Architecture

## Status
Accepted

## Context
Even within an offline, local application, internal layers cannot implicitly trust one another. If a bug or compromise occurs in the UI or State Management layer, it should not have unfettered access to plain-text secrets or cryptographic keys.

## Decision
We will implement a **Zero Trust Internal Architecture**.

## Principles
1. **Input Validation:** Every layer validates input before processing.
2. **No Implicit Trust:** No layer trusts another implicitly. The Repository layer must verify data hasn't bypassed encryption.
3. **Encryption Before Persistence:** Secrets are encrypted immediately before they are handed off to the Database layer.
4. **Just-In-Time Decryption:** Secrets are decrypted *only* when absolutely needed for display or copy operations.
5. **Shortest Memory Lifetime:** Decrypted data has the shortest possible lifetime in memory and is wiped/cleared as soon as possible.
6. **Opt-in Clipboard:** Clipboard usage is always explicitly triggered by the user and auto-clears after 30 seconds.
7. **Local Auditing:** Every security-sensitive action (e.g., viewing a secret, copying a key, failed unlock attempts) is audited locally.

## Consequences
* **Positive:** Massive defense-in-depth. A bug in one layer is highly unlikely to result in a catastrophic secret leak.
* **Negative:** Increased development overhead. We must write stricter validation logic and carefully manage object lifetimes in Dart.
