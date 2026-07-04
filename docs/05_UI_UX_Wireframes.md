# UI/UX Wireframes & Flow

Since this is a text-based document, this represents the structural flow and layout intent of the app screens.

## Core Principles
* **Dark Mode Default:** Developers prefer dark mode. Deep blacks, subtle greys, neon accents for categories (e.g., AWS Orange, GitHub Black/White).
* **Minimalist & Dense:** High information density without feeling cluttered.
* **Obfuscation First:** All secrets are masked `••••••••` by default. Requires a tap-and-hold or explicit "reveal" button to show.

## Screen Flow

### 1. Splash & Onboarding
* **Splash:** Minimal logo, dark background.
* **Onboarding (First Launch):**
  * Screen 1: "Your offline Developer Security Hub."
  * Screen 2: "Zero telemetry. Your keys, your device."
  * Screen 3: Create Master Password (strength meter requires strong password).

### 2. Unlock Screen
* Minimalist keypad / Biometric prompt.
* "Vault Locked" indicator.

### 3. Home Dashboard (The Hub)
* **Top:** Global Search Bar.
* **Hero:** Security Health Score (e.g., "3 secrets expiring soon").
* **Grid:** Categories (OpenAI, AWS, GitHub, Custom).
* **FAB (Floating Action Button):** Add new secret / Generate Key.

### 4. Vault List (Category View)
* List of items with icons.
* Subtitle shows partial description or tags.
* Swipe left to delete, swipe right to favorite.

### 5. Secret Details View
* Large title & category icon.
* **Fields:** Key, Name, Project, Environment, Expiry, Notes.
* **Actions:** Copy (auto-clears in 30s), Reveal, Edit, Share (Future).

### 6. Tools Section (Bottom Nav)
* **JWT Decoder:** Paste token -> shows Header, Payload, Signature validation.
* **Key Generator:** Sliders for length, toggles for symbols/numbers, dropdown for algorithm (UUID, RSA, AES).
* **API Tester:** Simple URL bar, Method dropdown, Headers table, Body textarea, Send button.

### 7. Settings
* Security (Auto-lock time, Change Master Password, Biometrics toggle).
* Backup (Export .vault, Import .vault).
* About & Open Source licenses.
