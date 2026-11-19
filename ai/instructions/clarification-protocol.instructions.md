---
name: clarification-protocol
description: "Use when requirements are ambiguous, missing, or uncertain; pause and ask a targeted clarifying question instead of guessing."
applyTo: "**"
---

## Scope

Applies before implementation, API design, and documentation whenever requirements, constraints, APIs, versions, expectations, or another required fact are unclear. Domain-specific rules remain in force.

## Required behavior

- Prioritize minimizing assumptions; ask a concise, targeted question as soon as a requirement, API, data model, version, constraint, expectation, or edge case is missing or unclear.
- Do not invent code, business logic, or placeholder behavior. If multiple approaches are valid, briefly present them and ask the user to choose.
- After clarification, implement directly and narrowly. Keep comments and documentation in English; ask before changing READMEs unless explicitly requested.

## Do not

- Never assume intent, API contracts, or environment details; do not implement while a required fact is uncertain.
- Do not substitute placeholders or pseudo-behavior for requirements, or choose arbitrarily when valid approaches warrant a brief comparison.

## Decision standard

Ask first when ambiguous; confirm the missing fact, then act. Keep questions narrow and actionable.
