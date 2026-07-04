# Coding Standards

Enforcing consistency prevents chaos as the codebase grows.

## 1. Architectural Rules
* **Feature-first architecture:** Code is organized by feature (e.g., `features/vault`, `features/auth`), not by type (e.g., all models in one folder, all views in another).
* **No business logic in UI:** Widgets handle rendering and delegating actions to Riverpod notifiers. They do not calculate or encrypt.
* **No direct database access from widgets:** The UI only talks to Repositories via State Management.

## 2. File & Function Constraints
* **Maximum file size:** 300 lines. If larger, refactor and extract widgets/logic.
* **Maximum function length:** 40 lines. Keep methods single-responsibility.

## 3. Naming Conventions
* `snake_case` for file and directory names.
* `PascalCase` for classes, enums, and typedefs.
* `camelCase` for variables, functions, and properties.
* Prefix private variables and methods with an underscore (`_`).

## 4. Documentation Requirements
* All public classes, methods, and providers MUST have a docstring (`///`).
* Explain the *why*, not just the *what*.

## 5. Version Control
* **Commit format:** Conventional Commits (`feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`).
* No secrets, API keys, or `.env` files committed. (Enforced via pre-commit hooks).
