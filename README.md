# Dotfiles

This repository contains a personal dotfiles setup for macOS and Linux. It uses a Makefile-driven installation flow and symlinks to keep shell, editor, Git, SSH, and toolchain configuration centralized, versioned, and easy to reapply on another machine.

## Overview

The root `Makefile` is the entry point for installation and maintenance. It installs the required Homebrew packages, optionally adds work-specific tooling, and then invokes the `install` target for each submodule that contains its own `Makefile`.

## Repository layout

- `config/` — additional machine configuration, currently including Spring Boot config
- `copilot/` — global Copilot instructions deployment
- `git/` — global Git configuration, bundled ignore/attributes repositories, and local override support
- `misc/` — Java, CA trust, and Node.js-related setup tasks
- `ssh/` — SSH client configuration and local override files
- `vim/` — Neovim configuration linked into `~/.config/nvim`
- `zsh/` — Zsh startup files, plugins, aliases, exports, and local overrides
- `make/` — shared Makefile helpers used across modules
- `docs/` — project makefile and maintenance notes
- `.github/` — GitHub metadata, issue templates, and automation

## Requirements

- macOS or Linux
- Homebrew
- `make`
- `git`
- `curl` for the Zsh bootstrap flow

## EditorConfig

The repository includes a root-level `.editorconfig` file to keep formatting consistent across editors.

Key rules:

- UTF-8 encoding
- LF line endings
- trailing whitespace removed
- final newline enforced
- tabs reserved for `Makefile` content

Editors with EditorConfig support will apply these settings automatically.

## Quick start

Clone the repository and inspect the available root targets:

```bash
git clone https://github.com/renatius-de/dotfiles.git
cd dotfiles
make help
```

Install the full setup:

```bash
make install
```

This installs Homebrew packages and runs the `install` target for each module with its own `Makefile`.

## Root Makefile targets

| Target | Purpose |
| --- | --- |
| `help` | Prints the list of available root targets |
| `install` | Installs Homebrew packages and triggers submodule installations |
| `upgrade` | Upgrades Homebrew packages and runs submodule upgrades |
| `clean` | Removes generated files, caches, and installed package state |
| `brew-install` | Installs the default Homebrew package set |
| `brew-upgrade` | Upgrades installed Homebrew formulas |
| `jenv-add-corretto` | Registers Amazon Corretto JDKs with `jenv` |

## Optional work environment

The root `Makefile` supports a work-oriented toolchain package set through the `WORK_ENV` variable:

```bash
WORK_ENV=true make install
```

This enables additional packages such as `azure-cli`, `helm`, `kubectl`, `nvm`, and Java-related tooling.

## Install individual modules

```bash
make -C zsh install
make -C vim install
make -C git install
make -C ssh install
make -C config install
make -C copilot install
make -C misc install
```

## Local overrides

Most modules rely on symlinks into `$HOME`, while machine-specific customizations should live in local override files instead of the tracked repository copies.

Common examples:

- `~/.gitconfig.local`
- `~/.ssh/config.local`
- `~/.zshrc.local`

## Maintenance

Preview a target without executing it:

```bash
make -n install
```

Upgrade all modules:

```bash
make upgrade
```

Clean the generated state:

```bash
make clean
```

## Documentation

- [docs/MAKEFILE.md](docs/MAKEFILE.md) — Makefile conventions and helpers
- [AGENTS.md](AGENTS.md) — repository maintenance guidance for AI assistants
- [config/README.md](config/README.md) — config module documentation
- [copilot/README.md](copilot/README.md) — global Copilot instructions deployment
- [git/README.md](git/README.md) — Git configuration and bundled metadata
- [misc/README.md](misc/README.md) — Java and environment setup details
- [ssh/README.md](ssh/README.md) — SSH setup and override guidance
- [vim/README.md](vim/README.md) — Neovim configuration
- [zsh/README.md](zsh/README.md) — Zsh configuration and plugin management

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process and standards.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## Security

For security issues, follow the guidance in [SECURITY.md](SECURITY.md).

## License

This project is distributed under the MIT license. See [LICENSE](LICENSE) for details.
