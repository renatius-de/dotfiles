# AGENTS

## Purpose
This repository is a personal dotfiles and configuration installation repo. It contains shell, editor, git, SSH, and auxiliary environment setup scripts and symlink-based configuration files.

## What AI agents should know
- Primary workflow is managed through GNU Make targets in the root `Makefile` and each subdirectory.
- The repo is meant for macOS/Linux development environments.
- Config files are normally installed by symlinking from the repo into the user's home directory.
- Do not assume a full application stack beyond Homebrew-managed packages and the local tools referenced in `Makefile`.
- Avoid making non-consensual or destructive changes to the user's home directory; focus on repository source files.

## Important files and directories
- `README.md` — repository overview, install instructions, and usage guidance.
- `Makefile` — root orchestration, Homebrew package management, and per-subdirectory install/upgrade/clean logic.
- `zsh/` — Zsh configuration and installation scripts.
- `vim/` — Vim/Neovim configuration and install scripts.
- `git/` — Git configuration and install scripts.
- `ssh/` — SSH configuration and install scripts.
- `config/` — additional configuration modules (for example Spring Boot config linking).
- `misc/` — utility scripts and helper tasks.
- `docker-compose.yml` — local container-based linting environment.
- `.github/workflows/security-scan.yml` — CI security scan workflow.

## Recommended commands
- `make install` — install Homebrew packages and run install targets for each subdirectory.
- `make upgrade` — upgrade Homebrew packages and run upgrade targets for each subdirectory.
- `make -C zsh install` — install only Zsh configuration.
- `make -C vim install` — install only Vim/Neovim configuration.
- `docker-compose up` — run the local container linter defined in `docker-compose.yml`.

## Agent behavior guidance
- Keep changes minimal and tied to repository configuration conventions.
- Prefer editing the dotfiles or Makefile in place rather than adding new unrelated scripts.
- If the task is to add or update functionality, update the appropriate subdirectory and its `Makefile` instead of the top-level build flow unless the change is global.
- Link to existing documentation rather than duplicating it. Use `README.md`, `CONTRIBUTING.md`, or `.github/workflows/security-scan.yml` for policy/details references.
- If a request involves package installation or environment setup, verify whether the change is best expressed in `Makefile` variables or in the relevant config subdirectory.
