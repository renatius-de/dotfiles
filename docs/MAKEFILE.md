# Makefile overview

The root `Makefile` handles Homebrew installation and delegates to module `Makefile`s.

## Root targets
- `make clean` — removes Homebrew packages and cleans module artifacts.
- `make install` — installs Homebrew packages and runs each module `install` target.
- `make upgrade` — upgrades Homebrew packages and runs each module `upgrade` target.

## Module directories
- `config/`
- `git/`
- `misc/`
- `ssh/`
- `vim/`
- `zsh/`

## Module installation
Run `make -C <directory> <target>` to install or update a single module.

## Symlink logic
Most modules create symlinks for configuration files in the home directory. Prefer editing the repository files rather than the symlinks directly.
