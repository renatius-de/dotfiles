---
name: dotfiles-workflow
description: "Use when changing this repository's dotfiles, installation flow, or system configuration; preserve module boundaries and user data."
applyTo: "**/*"
---

# Dotfiles Repository Workflow

## Scope

- Applies to changes in this personal macOS and Linux dotfiles repository.
- Keep guidance grounded in the repository's actual modules, Makefiles, and installation behavior.

## Required behavior

- Read the relevant module's Makefile and nearby configuration before changing its behavior.
- Make changes in repository sources rather than editing files directly in the user's home directory.
- Keep changes within the responsible module and follow the root and module-level Makefile conventions.
- Reuse `make/common.mk` helpers and preserve the symlink-based installation flow when working on Makefiles.
- Preserve existing local configuration and user data; inspect cleanup, replacement, and unlink behavior before changing it.
- Keep documentation aligned with verified repository behavior.

## Verification

- Use `make -n <target>` to inspect affected Makefile flows before running them.
- Run existing, relevant checks for the files changed; do not use destructive install or clean operations as validation.
- Review the final diff to confirm only the intended module and related documentation changed.

## Success criteria

- Changes remain scoped to the appropriate module and preserve existing installation behavior.
- Validation is relevant to the change, and no unrelated home-directory content is altered.
