# Git configuration

This module establishes the repository's global Git setup, including the main Git config, local overrides, and bundled repository metadata for ignore and attributes rules.

## Installation

```bash
make -C git install
```

The install target creates the required symlinks and ensures the bundled helper repositories are present.

## Managed items

- `~/.gitconfig` — global Git configuration
- `~/.gitconfig.local` — user-local override file
- `~/.gitignore` — shared ignore rules for the current machine
- `GitAttributesRepository/` — language-specific `.gitattributes` templates
- `GitIgnoreRepository/` — community-maintained `.gitignore` templates

## Included repositories

The `git/Makefile` keeps the following directories current:

- `git/GitAttributesRepository/`
- `git/GitIgnoreRepository/`

These repositories are refreshed when `install` or `upgrade` is run.

## Local overrides

Use `~/.gitconfig.local` for personal settings such as name, email, and local Git preferences:

```ini
[user]
    name = Your Name
    email = your.email@example.com
```

The main config includes this file when it exists.

## Notes

- This keeps Git behavior consistent across machines.
- The bundled ignore and attributes repositories reduce the need to maintain those files manually.
- Global ignore rules help avoid committing editor, OS, and build artifacts.
