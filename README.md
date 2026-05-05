# Public dotfiles

Personal configuration files and install scripts for macOS/Linux.

## What it contains
- Zsh configuration and plugin bootstrap — `zsh/`
- Vim/Neovim configuration — `vim/`
- Git configuration — `git/`
- SSH configuration — `ssh/`
- Utility scripts and helpers — `misc/`
- Additional config modules — `config/`
- Local lint environment — `docker-compose.yml`

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
- `AGENTS.md` — AI assistance guidance
- `CONTRIBUTING.md`
- `CODE_OF_CONDUCT.md`
- `SECURITY.md`
- `.github/workflows/security-scan.yml`

## License
MIT License — `LICENSE`
