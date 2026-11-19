---
name: documentation-governance
description: "Use when evaluating whether documentation or README files should be updated; require explicit approval before modifying or creating README files."
applyTo: "**/README.md,**/*.md"
---

## Scope

Applies to README files, documentation, and user-facing guidance when behavior, setup, configuration, or expectations change. Governs documentation approval, not code quality, Java, or OpenAPI contracts.

## Required behavior

- Whenever behavior, setup, configuration, or expectations change, assess documentation updates and keep docs aligned with implementation.
- Update non-README documentation only when directly relevant and accurate. README edits require explicit approval: briefly propose a necessary change before editing.

## Do not

- Never create or edit a README without explicit confirmation; avoid speculative claims, stale behavior, and scope beyond the change.

## Documentation standard

Keep documentation concise, relevant, maintainable, accurate, and English-only; prefer focused edits over broad rewrites.
