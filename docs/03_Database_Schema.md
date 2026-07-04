# Database Schema

Database Technology: SQLite (via Drift)

## Core Tables

### 1. `vault_items`
* `id` (UUID, Primary Key)
* `title` (String, Encrypted)
* `secret_value` (String, Encrypted)
* `description` (String, Encrypted)
* `category_id` (Foreign Key)
* `project_id` (Foreign Key)
* `environment` (String, Encrypted)
* `created_at` (DateTime)
* `updated_at` (DateTime)
* `last_used_at` (DateTime)
* `expires_at` (DateTime)
* `is_favorite` (Boolean)

### 2. `categories`
* `id` (UUID, Primary Key)
* `name` (String) - e.g., OpenAI, AWS, GitHub
* `icon` (String)

### 3. `tags`
* `id` (UUID, Primary Key)
* `name` (String)

### 4. `item_tags` (Many-to-Many)
* `item_id` (Foreign Key)
* `tag_id` (Foreign Key)

### 5. `projects`
* `id` (UUID, Primary Key)
* `name` (String)
* `description` (String)

### 6. `audit_logs`
* `id` (UUID, Primary Key)
* `action` (String) - e.g., 'Item Viewed', 'Item Created'
* `item_id` (Foreign Key, Nullable)
* `timestamp` (DateTime)

### 7. `settings`
* `key` (String, Primary Key)
* `value` (String) - e.g., 'auto_lock_duration', 'theme'
