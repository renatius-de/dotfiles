---
name: Makefile Standards
description: "Use for all Makefile and .mk files; keep them consistent with the repository's install flow, target naming, and status-reporting conventions."
applyTo: "**/Makefile,**/*.mk"
---

## Scope

- Applies to all Makefile and .mk files in this repository.
- Use this standard when editing installation logic, helper rules, shared Makefile includes, or task orchestration.

## Required behavior

- Review the existing Makefile structure before editing, especially the shared helpers in [make/common.mk](../../make/common.mk) and the root orchestration in [Makefile](../../Makefile).
- Use tab-indented recipe lines, consistent target naming, and the repository’s established conventions.
- Keep the target surface minimal and predictable.
- Treat Makefiles as operational automation, not generic shell scripts.
- Emit a concise status message in English before each significant recipe action.
- Emit a clear failure message in English when a target fails and identify the failing target explicitly.
- Prefer reusable helper patterns and shared conventions over duplicated logic.
- Keep recipes idempotent and safe to rerun when appropriate.
- Preserve the repository’s installation model: symlink-based setup, explicit directory creation, and root/submodule install flows must continue to work without breaking established patterns.
- Keep target comments aligned with actual behavior and use short, discoverable help text.

## Do not

- Do not add unrelated complexity, non-standard formatting, or shell shortcuts that diverge from the project style.
- Do not introduce stray phony targets unless the repository already requires them and the naming is consistent with established project conventions.
- Do not break the existing install, clean, or upgrade flow.
- Do not leave silent failures or unclear error reporting.

## Maintenance standard

- If you modify a Makefile, provide a brief summary in English describing the change and its purpose.
- Favor correctness and maintainability over clever shell logic.
