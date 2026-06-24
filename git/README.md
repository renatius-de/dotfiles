# Git Configuration

Git configuration files and templates for consistent version control across projects.

## Installation

Install the Git configuration:

```bash
make -C git install
```

This creates symlinks to Git configuration files in the home directory.

## Important Files

- `config` — Symlinked to `~/.gitconfig` (main Git configuration)
- `delta.gitconfig` — Delta diff tool configuration
- `ignore` — Symlinked to `~/.gitignore` (global ignore rules)
- `Makefile` — Installation and cleanup targets

## Repositories

The `Makefile` automatically manages:

- `GitAttributesRepository/` — Language-specific Git attributes (auto-cloned)
- `GitIgnoreRepository/` — Community gitignore templates (auto-cloned)

These are updated whenever the `install` or `upgrade` target runs.

## Local Overrides

Use `~/.gitconfig.local` for user-specific Git settings:

```bash
[user]
    name = Your Name
    email = your.email@example.com
```

The main `config` file includes this local file automatically.

## Features

- Consistent Git configuration across all machines
- Language-specific file attributes for proper diff handling
- Global gitignore rules for common files and directories
- Delta integration for improved diff visualization
