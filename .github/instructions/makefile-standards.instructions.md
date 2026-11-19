---
name: makefile-standards
description: "Use for Makefiles and .mk files; preserve the repository's installation flow, target conventions, and status reporting."
applyTo: "**/Makefile,**/*.mk"
---

# Makefile Standards

## Scope

Applies to repository Makefiles and `.mk` files, including installation logic, helpers, includes, and orchestration. Covers Makefile structure and behavior, not general code quality, API contracts, or documentation approval.

## Required behavior

- Before editing, review Makefile structure, especially [make/common.mk](../../make/common.mk) and the root [Makefile](../../Makefile).
- Use tab-indented recipe lines, consistent target naming, and the repository's established conventions.
- Keep the target surface minimal and predictable.
- Treat Makefiles as operational automation, not generic shell scripts.
- Before each significant recipe action, print a concise English status; on failure, print a clear English message naming the target.
- Prefer reusable helper patterns and shared conventions over duplicated logic.
- Keep recipes idempotent and safe to rerun when appropriate.
- Preserve symlink-based setup, explicit directory creation, and compatible root/submodule install flows.
- Link managed files and directories to their intended targets with `ln -sf`. Do not replace symlink creation with copying or direct duplication of repository content.
- Before linking, ensure the destination parent exists, using `mkdir -p` or the `make/common.mk` helper before `ln -sf`.
- Each `install` target must create required local files/directories before dependents run, using idempotent `mkdir -p`, `touch`, or shared helpers without overwriting existing content.
- Treat these local paths as mandatory installation prerequisites when applicable: `~/.gitconfig.local`, `~/.zshrc.local`, `~/.ssh/config.local`, and `~/.ssh/keys/`.
- Keep target comments accurate and help text concise and discoverable.

## Do not

- Avoid unrelated complexity, non-standard formatting, project-inconsistent shell shortcuts, and breaks to install/clean/upgrade flows. Add phony targets only when required by the repository and named consistently with its conventions.
- Never allow a `clean` target to delete, replace, unlink, or recursively remove local configuration files or directories.
- Protect `~/.gitconfig.local`, `~/.zshrc.local`, `~/.ssh/config.local`, and `~/.ssh/keys/` (including all key contents). Before cleanup changes, inspect every `rm`, `unlink`, wildcard, symlink replacement, and recursive deletion; a clean dry run must not target protected paths.
- Do not leave silent failures or unclear error reporting.

## Verification

- Run the narrowest relevant check; use `make -n` when a safe dry run can inspect the affected flow.
- Inspect expanded `install` commands for prerequisites before use and preservation of local content; verify symlink creation uses `ln -sf` after parent `mkdir -p`; ensure `clean` cannot remove protected paths or key contents; confirm root/module install compatibility.
- After creating or editing this instruction file, read `.github/instructions/makefile-standards.instructions.md` back from disk and explicitly verify that the protected paths, install prerequisites, cleanup prohibition, and validation requirements are all present and correct.

## Maintenance standard

- If you modify a Makefile, provide a brief summary in English describing the change and its purpose.
- Favor correctness and maintainability over clever shell logic.

## Success criteria

- The affected Makefile remains syntactically valid and follows repository conventions.
- The relevant target flow is observable, rerunnable, and compatible with existing install, clean, and upgrade behavior.