# Dotfiles

Personal configuration files and installation scripts for macOS and Linux.

## Overview

This repository manages dotfiles and configuration modules using symlink-based installation and
Makefile-driven orchestration. All configuration files are stored in this repository and
symlinked into the home directory, allowing version control and centralized management.

## Contents

- `config/` — Additional configuration modules (Spring Boot, etc.)
- `git/` — Git configuration and templates
- `misc/` — Utility scripts and Java configuration
- `ssh/` — SSH configuration and keys management
- `vim/` — Neovim configuration files
- `zsh/` — Zsh configuration and plugin setup
- `make/` — Shared Makefile utilities
- `.github/workflows/` — CI/CD pipelines

## Prerequisites

- macOS or Linux
- Homebrew (for package management)
- Make (for orchestration)
- Git (for cloning and operations)

## Editor configuration

This repository includes a `.editorconfig` file at the project root to enforce consistent file formatting:

- `utf-8` encoding for all files
- `lf` line endings
- trailing whitespace trimmed globally
- final newline inserted
- spaces for indentation in most files
- tabs only in `Makefile`
- Markdown files preserve trailing whitespace where needed

Editors that support EditorConfig will automatically apply these rules.

## Installation

Clone the repository:

```bash
git clone https://github.com/renatius-de/dotfiles.git
cd dotfiles
```

Run the installation:

```bash
make install
```

This installs Homebrew packages and runs the `install` target for each module.

### Install Individual Modules

To install only specific modules:

```bash
make -C zsh install    # Zsh configuration
make -C vim install    # Neovim configuration
make -C git install    # Git configuration
make -C ssh install    # SSH configuration
make -C config install # Additional config modules
make -C misc install   # Utility scripts and Java setup
```

## Usage

Configuration files are installed as symlinks in the home directory. Edit files directly in this repository:

```bash
~/.gitconfig -> /path/to/dotfiles/git/config
~/.config/nvim/init.lua -> /path/to/dotfiles/vim/init.lua
~/.zshrc -> /path/to/dotfiles/zsh/zshrc
```

Use local overrides for personal settings:

- `~/.gitconfig.local` — Git user settings
- `~/.ssh/config.local` — SSH host-specific configuration
- `~/.zshrc.local` — Zsh personal aliases and settings

## Maintenance

Upgrade all modules:

```bash
make upgrade
```

Clean up all modules:

```bash
make clean
```

Dry-run any target to see what will be executed:

```bash
make -n install
```

## Module Documentation

For detailed information about individual modules, see:

- [docs/MAKEFILE.md](docs/MAKEFILE.md) — Makefile overview and targets
- [AGENTS.md](AGENTS.md) — AI agent guidance for repository maintenance
- [config/README.md](config/README.md) — Configuration modules
- [git/README.md](git/README.md) — Git configuration
- [misc/README.md](misc/README.md) — Utility scripts
- [ssh/README.md](ssh/README.md) — SSH configuration
- [vim/README.md](vim/README.md) — Neovim configuration
- [zsh/README.md](zsh/README.md) — Zsh configuration

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Code of Conduct

This project is governed by the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## Security

For security issues, see [SECURITY.md](SECURITY.md).

## License

MIT License — see [LICENSE](LICENSE) for details.
