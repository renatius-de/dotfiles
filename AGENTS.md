# AGENTS

## Purpose
Personal dotfiles and install scripts for macOS/Linux.
The repository uses symlink-based config modules and `make` targets to install or update files.

## Key facts
- Config files are typically linked into the user home directory.
- Each module has its own `Makefile` under `zsh/`, `vim/`, `git/`, `ssh/`, `misc/`, and `config/`.
- Root `Makefile` manages Homebrew packages and runs subdirectory `install`, `upgrade`, and `clean` targets.
- The repo is not a full application stack; avoid assumptions beyond Homebrew and local shell/editor tooling.

## Important paths
- `.github/workflows/security-scan.yml` — CI security scan.
- `Makefile` — top-level orchestration.
- `README.md` — overview and usage.
- `config/` — additional configuration modules.
- `docker-compose.yml` — local lint container.
- `git/` — Git configuration and install scripts.
- `misc/` — utility scripts and helper tasks.
- `ssh/` — SSH configuration and install scripts.
- `vim/` — Vim/Neovim configuration and install scripts.
- `zsh/` — Zsh configuration and installation scripts.

## Recommended commands
- `docker-compose up`
- `make -C vim install`
- `make -C zsh install`
- `make install`
- `make upgrade`

## Guidance
- Avoid destructive edits to the user home directory.
- Keep changes focused on the relevant module and its `Makefile`.
- Prefer editing repo files and symlink logic over adding unrelated scripts.
- Use existing docs instead of duplicating them.
