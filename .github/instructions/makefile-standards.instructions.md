---
name: makefile-standards
description: "Use for Makefiles and .mk files; preserve the repository's installation flow, target conventions, and status reporting."
applyTo: "**/Makefile,**/*.mk"
---

# Makefile Standards

## Scope

- Applies to all Makefiles and `.mk` files in this repository.
- Use this standard when editing installation logic, helper rules, shared Makefile includes, or task orchestration.
- This rule covers Makefile structure and operational behavior only. It does not define general code quality, API contracts, or documentation approval policy.

## Required behavior

- Review the existing Makefile structure before editing, especially the shared helpers in [make/common.mk](../../make/common.mk) and the root orchestration in [Makefile](../../Makefile).
- Use tab-indented recipe lines, consistent target naming, and the repository's established conventions.
- Keep the target surface minimal and predictable.
- Treat Makefiles as operational automation, not generic shell scripts.
- Emit a concise status message in English before each significant recipe action.
- Emit a clear failure message in English when a target fails and identify the failing target explicitly.
- Prefer reusable helper patterns and shared conventions over duplicated logic.
- Keep recipes idempotent and safe to rerun when appropriate.
- Preserve the repository's installation model: symlink-based setup, explicit directory creation, and root/submodule install flows must continue to work without breaking established patterns.
- Make every `install` target ensure that required local files and directories exist before dependent steps run. Use idempotent operations such as `mkdir -p` and `touch`, or the established helpers from `make/common.mk`, and preserve existing local content.
- Treat these local paths as mandatory installation prerequisites when applicable: `~/.gitconfig.local`, `~/.zshrc.local`, `~/.ssh/config.local`, and `~/.ssh/keys/`.
- Keep target comments aligned with actual behavior and use short, discoverable help text.

## Do not

- Do not add unrelated complexity, non-standard formatting, or shell shortcuts that diverge from the project style.
- Do not introduce stray phony targets unless the repository already requires them and the naming is consistent with established project conventions.
- Do not break the existing install, clean, or upgrade flow.
- Never allow a `clean` target to delete, replace, unlink, or recursively remove local configuration files or directories.
- Keep `~/.gitconfig.local`, `~/.zshrc.local`, `~/.ssh/config.local`, and `~/.ssh/keys/` absolutely protected. All contents under `~/.ssh/keys/` are protected as well.
- Before changing cleanup logic, inspect every `rm`, `unlink`, wildcard, symlink replacement, and recursive deletion path. A clean dry run must not target any protected path.
- Do not leave silent failures or unclear error reporting.

## Verification

- Run the narrowest relevant Makefile check after editing.
- Use `make -n` to inspect the affected flow when a dry run can validate the change safely.
- Inspect the expanded `install` commands to confirm that required local files and directories are created before use and that existing local content is not overwritten.
- Inspect the expanded `clean` commands to confirm that no protected path or content under `~/.ssh/keys/` can be deleted.
- Confirm that modified targets remain compatible with the root and module-level install flows.
- After creating or editing this instruction file, read `.github/instructions/makefile-standards.instructions.md` back from disk and explicitly verify that the protected paths, install prerequisites, cleanup prohibition, and validation requirements are all present and correct.

## Maintenance standard

- If you modify a Makefile, provide a brief summary in English describing the change and its purpose.
- Favor correctness and maintainability over clever shell logic.

## Success criteria

- The affected Makefile remains syntactically valid and follows repository conventions.
- The relevant target flow is observable, rerunnable, and compatible with existing install, clean, and upgrade behavior.