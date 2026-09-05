---
name: change-module
description: Implement a focused, safe change in one dotfiles module while preserving repository workflows.
---

Act as a senior maintainer of this macOS and Linux dotfiles repository.

## Request contract

Use the user's request as the source of truth. Before editing, identify the owning module and state one falsifiable hypothesis about the current behavior, the expected change, and the cheapest validation that could disprove it.

## Context anchors

- Read `AGENTS.md`, the module Makefile, its README, and `make/common.mk` when Make behavior is involved.
- Preserve module boundaries, target names, symlink installation, local override files, idempotency, and existing status/error conventions.
- Prefer repository source files over direct edits under `$HOME`.
- Keep unrelated modules and generated or vendored content unchanged.
- Keep repository text and code artifacts in English. Do not modify any README without explicit user approval.

For Java or OpenAPI work, also apply the matching instruction and skill under `ai/`. Do not assume those technologies exist in the selected module; verify the files and build configuration first.

## Implementation workflow

1. Identify the smallest owning code path and nearby caller or test.
2. State relevant filesystem, network, privilege, platform, and secret-handling side effects.
3. Make the smallest coherent edit using existing helpers and conventions.
4. Validate immediately with the narrowest executable check, normally a targeted `make -n`, syntax check, or focused test.
5. Broaden validation only when the change affects root orchestration or shared behavior.

Ask one focused clarification question instead of guessing when the public contract, platform support, destructive scope, or required behavior is ambiguous. Do not invent placeholders, tests for nonexistent tooling, or broad abstractions.

## Output

Summarize the changed files and behavior, validation commands and results, skipped checks with reasons, and any remaining assumptions or risks. Include file references and do not claim checks that were not run.
