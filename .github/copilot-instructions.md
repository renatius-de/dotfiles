# GitHub Copilot Instructions

This repository manages personal macOS and Linux dotfiles through module-specific configuration, GNU Make, and
symlinks. The repository is the source of truth; installation targets link its files into the user's home directory.

## Repository workflow

- Identify the owning module before editing. Read its `Makefile` and README when present; read `make/common.mk` before
  changing shared Makefile behavior.
- Keep changes focused on the relevant module and preserve root/module target behavior, symlink setup, and local
  override files.
- Change tracked repository sources, not installed copies in `$HOME`. Do not overwrite machine-specific configuration.
- Reuse existing helpers and tools. Avoid unrelated dependencies, abstractions, and cleanup.

## Safety and validation

- Treat `install`, `upgrade`, and `clean` as potentially side-effectful. Prefer `make -n <target>` or a module-specific
  dry run when it is sufficient; inspect commands that remove, replace, or link filesystem paths.
- Do not add credentials, private keys, tokens, or machine-specific secrets to tracked files.
- Run the narrowest relevant existing check. For AI instructions, skills, or prompts, run `python3 ai/audit_assets.py`.
- Report the checks run and disclose any skipped checks; do not claim unverified results.

For detailed maintenance guidance, see [AGENTS.md](../AGENTS.md), the
[dotfiles maintenance instructions](instructions/dotfiles-maintenance.instructions.md), and the
[Makefile standards](instructions/makefile-standards.instructions.md).
