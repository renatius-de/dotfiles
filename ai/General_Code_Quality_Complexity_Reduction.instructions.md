---
name: General Code Quality and Complexity Reduction
description: "Use for implementation work across languages; simplify logic, prefer early exits, and keep code readable and maintainable."
applyTo: "**"
---
- Reduce cyclomatic and cognitive complexity in all code you write or modify.
- Keep nesting shallow; prefer a maximum of two conditional levels before extracting a helper or returning early.
- Use guard clauses and early exits to handle invalid input and edge cases before deeper logic.
- Break complex behavior into small, single-responsibility functions or components with clear names.
- Prefer declarative and straightforward patterns over clever or over-abstracted solutions when the simpler option is clearer.
- Keep variable names, function names, and control flow explicit so the code is easy to reason about.
- Write English error messages that explain what failed, why it failed, and which context or input triggered the issue, without leaking sensitive data.
- Avoid generic failure text like "An error occurred" or "Invalid input" when a more specific explanation is possible.
