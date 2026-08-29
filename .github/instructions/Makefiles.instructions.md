---
name: Makefile Standards
description: "Use for all Makefile and .mk files; keep them consistent with the repository's install flow, target naming, and status-reporting conventions."
applyTo: "**/Makefile,**/*.mk"
---
- Review the existing Makefile structure before editing, especially the shared helpers in make/common.mk and the root orchestration in Makefile.
- Standardize Makefiles across the repository for layout, naming, and syntax. Use tab-indented recipe lines, consistent target naming, and the same conventions already used in this project.
- Keep the target surface minimal and predictable. The valid phony targets are clean, install, and upgrade; remove or replace any other .PHONY entries unless a project-specific helper target is already established and required by the repo's conventions.
- Treat Makefiles as operational automation, not generic shell scripts. Every recipe action must emit a concise status message in English before execution and a clear failure message in English when a target fails.
- When a recipe fails, explicitly name the failing target in the error output, for example: "ERROR: target [install] failed..." or "ERROR: target [clean] failed...".
- Prefer reusable helper patterns and shared conventions over duplicated logic. Keep recipes idempotent and safe to rerun when appropriate.
- Preserve the repository's installation model: symlink-based setup, explicit directory creation, and root/submodule install flows should continue to work without breaking existing patterns.
- Keep target comments aligned with actual behavior and use short help descriptions so the Makefile stays discoverable and consistent.
- If you modify a Makefile, provide a brief summary in English describing the change and its purpose.
- Avoid unrelated complexity, non-standard formatting, or shell shortcuts that diverge from the established repository style.