# ADR 009: Search Architecture

## Context
When searching for secrets, a naive approach would be to decrypt every single secret payload in the database and perform a text comparison. This scales terribly and degrades performance as the vault grows (e.g., 5000+ secrets). We need a mechanism to search securely without exposing metadata or destroying performance.

## Evaluated Options

### Option A: Decrypt Everything
- **Pros**: Simplest to implement.
- **Cons**: Extremely slow. CPU bound. Terrible battery usage. 

### Option B: Encrypted Search Index
- **Pros**: Fast lookups using a pre-computed index.
- **Cons**: Complex to manage. Must carefully avoid leaking token frequencies.

### Option C: Deterministic Encrypted Metadata
- **Pros**: Fast equality checks.
- **Cons**: Susceptible to frequency analysis. Only works for exact matches, not partial substring searches.

### Option D: Searchable Blind Index (Recommended)
- **Pros**: Fast and secure. We generate a HMAC-based blind index (e.g., truncating SHA-256 of lowercase tokens) and store those tokens alongside the secret. Search involves generating the blind index of the query and querying the DB for that exact token. 
- **Cons**: Requires tokenization of text before saving. Can leak word presence, but not word order or exact context if salted per vault.

## Decision
For now, we document these strategies. The recommended approach for future implementation is **Option D (Blind Index)**, allowing fast database-level lookups for exact token matches without decrypting payloads. Until then, any implementation must be careful to respect the performance envelope.
