---
name: code-quality-complexity
description: "Use for implementation work across languages; reduce complexity, prefer early exits, and keep logic readable and maintainable."
applyTo: "**"
---

## Scope

Applies to implementation, refactoring, and bug fixes across project code, scripts, configuration, and automation. Covers structure and maintainability, not OpenAPI contracts, README approval, or documentation language.

## Required behavior

- Reduce cyclomatic and cognitive complexity. Keep nesting to at most two conditional levels; use guard clauses/early returns and extract clear, single-purpose helpers for complex behavior.
- Prefer direct, declarative solutions over cleverness or needless abstraction. Keep names and control flow explicit.
- Write English errors that explain what failed, why, and relevant context without exposing sensitive data.

## Do not

- Avoid needless abstraction, deep nesting when guards/helpers simplify it, generic errors when specifics are available, unclear names, and mixed responsibilities.

## Quality standard

Favor readable, maintainable logic that is easy to follow in one pass; use the simplest correct solution consistent with project conventions.
