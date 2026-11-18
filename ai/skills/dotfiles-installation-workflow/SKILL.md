---
name: dotfiles-installation-workflow
description: "Safely analyze and maintain the repository's symlink-based install, upgrade, and clean workflows across root and module Makefiles."
---

# Maintain Dotfiles Installation Workflows

Use this skill when changing or reviewing the repository's root or module Makefiles, shared Make helpers, or other automation that installs, upgrades, or removes dotfiles and related tooling.

## Scope

Preserve the repository's modular Makefile workflow and symlink-based configuration model. Keep changes focused on the affected target flow, and treat operations against the user's home directory, installed packages, external repositories, and local configuration as potentially destructive or externally visible.

Follow the repository's Makefile standards in `.github/instructions/makefile-standards.instructions.md`. This skill provides a workflow for lifecycle changes; it does not replace those standards.

## Required workflow

### 1. Establish the target and dependency flow

Before editing:

- Read the root `Makefile`, `make/common.mk`, and each affected module Makefile.
- Trace prerequisite and recursive target relationships for `install`, `upgrade`, and `clean`; do not assume that a target only affects its own module.
- Inspect shared helper definitions before changing or bypassing them.
- Identify platform assumptions, required commands, environment variables, package-manager calls, network access, and privileged operations.
- Check repository status and preserve unrelated user changes.
- Read relevant Makefile standards and documentation when they define the affected workflow.

If a target's ownership, side effects, platform support, or compatibility requirements cannot be determined, ask a focused question before changing behavior.

### 2. Classify paths and side effects

For every affected path, determine whether it is:

- a tracked repository source
- an intended symlink destination
- a user-owned local override or private-data location
- a generated cache or other removable artifact
- a prerequisite directory or external package/repository

Treat these paths as protected local configuration when applicable:

- `~/.gitconfig.local`
- `~/.zshrc.local`
- `~/.ssh/config.local`
- `~/.ssh/keys/`, including its contents

Do not edit files under the user's home directory as a substitute for repository changes. Do not expose private host details, key material, credentials, or local override contents in output.

Before changing cleanup or link-replacement behavior, inspect every `rm`, `unlink`, wildcard, recursive deletion, and symlink operation. Confirm exactly which destination is affected and whether an existing regular file, directory, local override, or user-created content could be removed. Never expand cleanup to a protected path. If the impact of replacing or deleting existing user content is uncertain, stop and ask for approval rather than assuming it is safe.

### 3. Make the smallest lifecycle change

- Preserve the root-to-module orchestration and existing target dependencies unless the requested behavior requires a change.
- Prefer the shared helpers and established target/status conventions over duplicated recipe logic.
- Keep install behavior rerunnable where appropriate; create required directories and local files without overwriting existing local content.
- Keep managed repository files linked to their intended destinations; do not silently switch between linking and copying.
- Keep `upgrade` behavior distinct from `install` where the module performs package upgrades, network updates, or other side effects.
- Limit `clean` to explicitly intended generated artifacts and managed destinations. Do not assume a `clean` target is safe merely because of its name.
- Do not add package, network, or privileged operations without a clear requirement and appropriate user approval.
- Update directly related documentation only when necessary and approved under the repository's documentation rules.

### 4. Validate without changing the user's machine

Start with static inspection and the narrowest applicable checks:

1. Use `make -n` for the affected root or module target to inspect expanded commands and paths.
2. Review the dry-run output for prerequisite ordering, local-file preservation, symlink destinations, package or network operations, and every cleanup target.
3. For cleanup changes, inspect `make -n clean` and confirm no protected path or user-owned content is targeted.
4. For install changes, inspect `make -n install` and confirm required local files and parent directories are handled before dependent steps.
5. Run syntax checks or focused repository tests when available.

A dry run is evidence about expanded commands, not proof that a target is safe or correct. Do not run `install`, `upgrade`, or `clean` against the user's home directory, install or remove packages, contact external services, or change permissions without explicit user approval. If execution is approved, use an isolated test location when the workflow supports it, inspect the effects, and report any operation that could not be safely tested.

After editing, reread every changed file and inspect the final diff. Report the exact checks run and distinguish dry-run evidence from executed behavior.

## Anti-patterns to avoid

- Do not run install, upgrade, or clean targets as a syntax check.
- Do not assume that `make -n` prevents every parse-time or explicitly forced recipe side effect; inspect the Makefiles and output.
- Do not use broad recursive deletion, wildcards, or cleanup lists without validating their fully expanded targets.
- Do not overwrite local configuration or private data while creating symlinks or local prerequisite files.
- Do not bypass shared helpers without a concrete reason and equivalent safety checks.
- Do not claim a workflow is idempotent, safe, or validated based only on reading its target name.
- Do not make unrelated home-directory, package, shell, editor, SSH, or documentation changes.

## Expected output

Report:

1. the targets and modules in scope and their relevant dependencies
2. path ownership and operational side effects reviewed
3. files changed and the reason for each change
4. dry-run, syntax, or test commands executed and their results
5. untested effects, unresolved assumptions, or risks requiring user approval

## Success criteria

The lifecycle change is complete when the affected target flow is understood end to end, local configuration and user data remain protected, cleanup targets are explicit and reviewed, repository conventions are preserved, and validation evidence accurately reflects what was and was not executed.
