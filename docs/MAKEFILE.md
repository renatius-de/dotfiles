# Makefile Overview

The root `Makefile` orchestrates package management and delegates to module-specific
Makefiles. All modules follow a consistent make target structure.

## Root Targets

- `make install` — Installs Homebrew packages and runs each module's `install` target
- `make upgrade` — Upgrades Homebrew packages and runs each module's `upgrade` target
- `make clean` — Removes Homebrew packages and cleans module artifacts
- `make brew-install` — Installs Homebrew packages only
- `make brew-upgrade` — Upgrades Homebrew packages only
- `make brew-cleanup` — Removes unused packages and cached files
- `make install-homebrew-extensions` — Installs work environment packages (when `WORK_ENV=true`)

## Module Directories

Each module has its own `Makefile` and can be managed independently:

- `config/` — Additional configuration modules
- `git/` — Git configuration and templates
- `misc/` — Utility scripts and Java configuration
- `ssh/` — SSH configuration and keys
- `vim/` — Neovim configuration
- `zsh/` — Zsh configuration and plugins

## Module Targets

All modules support these standard targets:

- `install` — Creates symlinks and configures the module
- `upgrade` — Updates module configuration and dependencies
- `clean` — Removes module artifacts and symlinks

## Installing Individual Modules

Run a specific module's target with:

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

Preview what a target will do without executing it:

```bash
make -n install
make -n -C zsh install
```

## Symlink Logic

Most modules create symlinks for configuration files in the home directory. Edit files directly in the repository:

- Changes in the repository are reflected immediately via symlinks
- Prefer editing repository files rather than symlinks in `$HOME`
- Use local override files (e.g., `~/.gitconfig.local`) for personal settings

## Environment Variables

- `WORK_ENV` — Set to `true` to enable work environment packages (Java, Kubernetes tools, etc.)
- `STORE_PASS` — Password for Java keystore operations (default: `changeit`)

Example:

```bash
WORK_ENV=true make install
```

## Shared Utilities

All Makefiles include `make/common.mk`, which provides:

- Standard tool commands (`BREW`, `CURL`, `RM_F`, `RM_RF`)
- Helper functions (`ensure_cmd`, `symlink`, `create_local_file`)
- Shell configuration for consistent behavior
