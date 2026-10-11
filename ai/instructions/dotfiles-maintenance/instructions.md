---
name: dotfiles-maintenance
description: "Use when changing this repository's dotfiles, installation flow, or module documentation; preserve its module boundaries and safe symlink-based workflow."
applyTo: "**"
---

# Dotfiles Repository Maintenance

## Scope

Apply these instructions to changes in this repository. It manages personal macOS and Linux configuration through module-specific files and a Makefile-driven, symlink-based installation flow.

## Required workflow

1. Inspect the relevant module, its `Makefile`, and any shared helpers or documentation before editing.
2. Keep changes focused on the responsible module. Update repository-managed source files, not installed copies in `$HOME`.
3. Preserve the existing root and module Makefile conventions. Reuse helpers from `make/common.mk`; do not restore duplicated logic or add dependencies and abstractions without a demonstrated need.
4. Keep behavior compatible with the configured macOS and Linux environments. Do not assume tools or paths beyond those already required by the repository.
5. Validate with the narrowest existing checks. For installation-flow changes, start with a dry run such as `make -n install` or the affected module's dry run. Run relevant existing tests or checks when available.
6. Review the final diff for unrelated changes, destructive filesystem effects, and consistency between documentation and actual behavior.

## Safety

- Do not modify user-home files directly or run installation, upgrade, or clean targets when a dry run or static inspection is sufficient.
- Preserve local override files and machine-specific configuration; do not replace them with tracked personal values.
- Do not add credentials, private keys, tokens, or machine-specific secrets to tracked files.
- Inspect commands that remove, replace, or link filesystem paths before changing or running them.

## Completion

Report what changed and which checks were run. If a check could not be run, state why; do not claim unverified behavior.
