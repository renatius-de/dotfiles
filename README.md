# Public dotfiles

Personal configuration files and install scripts for macOS/Linux.

## What it contains
- Additional config modules — `config/`
- Git configuration — `git/`
- Local lint environment — `docker-compose.yml`
- SSH configuration — `ssh/`
- Utility scripts and helpers — `misc/`
- Vim/Neovim configuration — `vim/`
- Zsh configuration and plugin bootstrap — `zsh/`

## Install
1. Clone the repository.
2. From the repository root run:
   - `make install` — install Homebrew packages and run each subdirectory `install` target.
   - `make -C zsh install` — install only Zsh configuration.
   - `make -C vim install` — install only Vim/Neovim configuration.

## Usage
Configuration files are installed as symlinks into `$HOME`.
Use local overrides like `~/.gitconfig.local` or `~/.ssh/config.local`.

Run the local linter with:
- `docker-compose up`

## Related
- `.github/workflows/security-scan.yml`
- `AGENTS.md` — AI assistance guidance
- `CODE_OF_CONDUCT.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `docs/MAKEFILE.md` — root Makefile overview
- `config/README.md`
- `git/README.md`
- `misc/README.md`
- `ssh/README.md`
- `vim/README.md`
- `zsh/README.md`

## License
MIT License — `LICENSE`
