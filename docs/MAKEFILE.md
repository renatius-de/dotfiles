# Makefile Overview

The root `Makefile` is the entry point for package installation and module orchestration. Each configuration module has its own `Makefile` and follows the same small set of standard targets.

## Root Targets

The main targets in the repository root:

- `make install` — installs Homebrew packages and runs the `install` target in each module
- `make upgrade` — upgrades installed packages and runs the module-level `upgrade` targets
- `make clean` — removes generated artifacts and uninstallable package entries
- `make brew-install` — installs the default Homebrew bundle only
- `make brew-upgrade` — upgrades the default package set only
- `make brew-cleanup` — removes unused packages and caches
- `make install-homebrew-extensions` — installs additional work-environment packages when `WORK_ENV=true`

## Module Layout

Each module can be managed independently:

- `config/` — additional configuration modules
- `git/` — Git configuration and repository helpers
- `misc/` — Java/tooling setup and utility tasks
- `ssh/` — SSH client configuration
- `vim/` — Neovim configuration
- `zsh/` — shell configuration and plugin setup

## Standard Module Targets

Most modules expose the same basic targets:

- `install` — sets up symlinks and required directories
- `upgrade` — re-runs the setup flow
- `clean` — removes installed artifacts for that module

## Running a Specific Module

Use the module directory as the working directory:

```bash
make -C <module> <target>
```

Examples:

```bash
make -C zsh install
make -C vim upgrade
make -C git clean
```

## Dry Run

Preview actions without executing them:

```bash
make -n install
make -n -C zsh install
```

## Symlink-Based Setup

The project primarily installs files by creating symlinks from the repository into `$HOME`.

This means:

- the source of truth lives in the repository
- changes are reflected immediately in the target environment
- local override files remain the appropriate place for machine-specific settings

Examples:

- `~/.gitconfig.local`
- `~/.ssh/config.local`
- `~/.zshrc.local`

## Environment Variables

A few Makefiles rely on environment variables:

- `WORK_ENV` — set to `true` to install work-specific Homebrew packages and Java tooling
- `STORE_PASS` — keystore password used by Java certificate import tasks

Example:

```bash
WORK_ENV=true make install
```

## Shared Utilities

All module Makefiles include `make/common.mk`, which centralizes shared logic such as:

- shell defaults and strict flags
- `BREW` detection
- `ensure_cmd` and `ensure_dir`
- `symlink` and `create_local_file`
- shared error output and validation helpers

This keeps the module Makefiles smaller and consistent across the project.
