# Git Configuration

This module manages the global Git configuration used across the system. It installs a shared Git config, keeps a local override file available, and maintains bundled gitignore and gitattributes metadata.

## Installation

```bash
make -C git install
```

This creates the required symlinks and ensures the bundled helper repositories are present.

## Managed Files

- `config` → `~/.gitconfig`
- `delta.gitconfig` → editor/diff configuration for Git
- `ignore` → `~/.gitignore`
- `Makefile` → install and cleanup logic

## Included Repositories

The `Makefile` automatically maintains:

- `git/GitAttributesRepository/` — language-specific `.gitattributes` definitions
- `git/GitIgnoreRepository/` — community-maintained `.gitignore` templates

These repositories are updated when the `install` or `upgrade` target is run.

## Local Overrides

Use `~/.gitconfig.local` for personal Git settings:

```ini
[user]
    name = Your Name
    email = your.email@example.com
```

The main Git config is designed to include this local file when present.

## Notes

- This keeps Git behavior consistent across machines.
- The bundled attribute and ignore repositories reduce the need to maintain those files manually.
- Global ignore rules help avoid committing editor, OS, and build artifacts.
