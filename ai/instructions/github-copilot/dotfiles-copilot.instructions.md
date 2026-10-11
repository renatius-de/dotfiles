---
name: dotfiles-copilot
description: "Use when GitHub Copilot works in this dotfiles repository; follow its module boundaries, safe installation workflow, and validation conventions."
applyTo: "**"
---

# GitHub Copilot guidance for dotfiles

## Scope

- Apply these rules only when working in the `renatius-de/dotfiles` repository.
- Treat this file as repository-specific guidance alongside the root `AGENTS.md` and any relevant module instructions.

## Repository context

This repository manages personal macOS and Linux configuration through module Makefiles and symlinks. The root `Makefile` orchestrates package setup and module targets; `ai/Makefile` links the repository's instruction and skill trees into user-level agent directories.

- `ai/instructions/` contains repository-managed agent instructions; follow its asset conventions when editing AI guidance.
- `config/`, `git/`, `misc/`, `ssh/`, `vim/`, and `zsh/` contain distinct configuration modules.
- `make/common.mk` provides shared Makefile helpers; reuse those helpers rather than duplicating setup logic.
- `docs/MAKEFILE.md` documents Makefile targets and conventions.

## Working rules

- Inspect the relevant module, its Makefile, and applicable instructions before changing behavior.
- Keep edits in the repository and within the module responsible for the behavior; do not edit files in `$HOME` as a substitute.
- Preserve the existing symlink-based, repeatable installation flow and root-to-module target structure.
- Use only assumptions supported by the repository's configuration; distinguish optional work tooling from the default setup.
- Keep changes narrowly scoped and avoid unrelated refactors, new dependencies, or new abstractions.
- Do not overwrite local overrides or perform destructive home-directory operations.
- Never include real credentials, private keys, or tokens in tracked files, examples, or output; use clearly fake placeholders when needed.

## Validation and delivery

- Select checks that match the files changed; do not run installation targets that modify a user's home directory unless explicitly requested.
- For Makefile changes, use the relevant module's dry run, such as `make -n install` or `make -C <module> -n install`.
- For AI asset changes, reread the file and run `python3 ai/audit_assets.py`.
- For other changes, use the existing project checks and state clearly which checks were run and any limitations.
- Ensure documentation describes verified behavior and keep changes consistent with applicable repository guidance.
