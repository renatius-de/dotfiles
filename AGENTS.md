# AI Agent Guidance

This document is intended for AI assistants working on this repository. It describes the repository’s purpose, the expected maintenance patterns, and the safe boundaries for edits.

## Purpose

This repository holds personal dotfiles and installation logic for macOS and Linux systems. It relies on a symlink-based installation flow and a set of `Makefile` targets to manage configuration, package installation, and filesystem setup.

## Core Principles

- Keep changes focused on the relevant module and its configuration files.
- Prefer updating repository files over editing files in `$HOME` directly.
- Keep the workflow aligned with the existing Makefile structure and module boundaries.
- Avoid introducing unrelated scripts, dependencies, or abstractions.
- Preserve the repository’s personal-system focus and avoid assumptions beyond the configured toolchain.

## Important Paths

- `Makefile` — root orchestration entry point
- `make/common.mk` — shared Makefile helpers and common variables
- `config/` — configuration modules
- `git/` — Git configuration and repository setup
- `misc/` — utility scripts and Java/tooling setup
- `ssh/` — SSH configuration and local overrides
- `vim/` — Neovim configuration
- `zsh/` — Zsh configuration and plugin management
- `README.md` — project overview
- `docs/MAKEFILE.md` — Makefile-oriented documentation

## Recommended Commands

```bash
make install
make upgrade
make clean
make -C zsh install
make -C vim install
make -C git install
make -n install
```

## Best Practices

- Avoid destructive changes to user home directory content.
- Keep documentation aligned with the actual `Makefile` behavior.
- Prefer reuse of shared helpers in `make/common.mk` over restoring duplicated logic.
- Validate edits with a dry run before committing.
- Keep change sets small and module-specific.

## Scope

This repository primarily covers:

- Makefile orchestration and root-level setup
- symlink installation logic
- shell configuration, Git, SSH, Vim, and Zsh modules
- project documentation and maintenance guidance

## When to Update This Repository

Typical maintenance tasks include:

- adjusting installation or symlink behavior
- refining module documentation and Makefile targets
- fixing root-level orchestration or shared helpers
- simplifying or modernizing configuration logic

## Related Documentation

- [README.md](README.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [SECURITY.md](SECURITY.md)
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- [docs/MAKEFILE.md](docs/MAKEFILE.md)
