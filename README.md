# Dotfiles

This repository contains a curated set of personal dotfiles and installation scripts for macOS and Linux. It uses a symlink-based layout and a Makefile-driven workflow to keep configuration centralized, versioned, and easy to apply across machines.

## Overview

The repository is organized into configuration modules, each with its own `Makefile` and a focused responsibility. The root `Makefile` installs Homebrew packages and delegates to module-specific install or upgrade targets.

## Repository Layout

- `config/` — additional configuration modules such as Spring Boot settings
- `git/` — Git configuration, templates, and shared repo metadata
- `misc/` — Java/tooling setup, CA import logic, and utility tasks
- `ssh/` — SSH client configuration and key directory setup
- `vim/` — Neovim configuration
- `zsh/` — Zsh configuration, aliases, exports, and plugin setup
- `make/` — shared Makefile utilities and helper functions
- `.github/` — issue templates and CI metadata

## Requirements

- macOS or Linux
- Homebrew
- `make`
- `git`

## Editor Configuration

The repository includes a root-level `.editorconfig` file to keep formatting consistent across editors.

Key rules:

- UTF-8 encoding
- LF line endings
- trailing whitespace trimmed
- final newline enforced
- spaces used for most file types
- tabs reserved for `Makefile` content

Editors with EditorConfig support will apply these rules automatically.

## Installation

Clone the repository:

```bash
git clone https://github.com/renatius-de/dotfiles.git
cd dotfiles
```

Install the full setup:

```bash
make install
```

This installs the Homebrew packages defined in the root `Makefile` and then invokes the `install` target for each module.

### Install Individual Modules

```bash
make -C zsh install
make -C vim install
make -C git install
make -C ssh install
make -C config install
make -C misc install
```

## Usage

Most files are installed into `$HOME` via symlinks. For example:

```bash
~/.gitconfig -> /path/to/dotfiles/git/config
~/.config/nvim/init.lua -> /path/to/dotfiles/vim/init.lua
~/.zshrc -> /path/to/dotfiles/zsh/zshrc
```

Use local override files for machine-specific settings:

- `~/.gitconfig.local`
- `~/.ssh/config.local`
- `~/.zshrc.local`

## Maintenance

Upgrade all modules:

```bash
make upgrade
```

Clean generated artifacts and symlinks:

```bash
make clean
```

Preview a target without executing it:

```bash
make -n install
```

## Documentation

Detailed guidance for the project and individual modules:

- [docs/MAKEFILE.md](docs/MAKEFILE.md) — root Makefile and common patterns
- [AGENTS.md](AGENTS.md) — repository maintenance guidance for AI assistants
- [config/README.md](config/README.md) — config module overview
- [git/README.md](git/README.md) — Git setup and repository handling
- [misc/README.md](misc/README.md) — Java and utility tooling setup
- [ssh/README.md](ssh/README.md) — SSH configuration and security notes
- [vim/README.md](vim/README.md) — Neovim setup
- [zsh/README.md](zsh/README.md) — Zsh setup and plugin management

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution workflow and standards.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## Security

For security issues, follow the guidance in [SECURITY.md](SECURITY.md).

## License

This project is distributed under the MIT license. See [LICENSE](LICENSE) for details.
