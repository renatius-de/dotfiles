# Neovim Configuration

This module manages the repository version of the Neovim configuration and links it into the expected `$HOME` location.

## Installation

```bash
make -C vim install
```

This creates the required directories and links the repository `init.lua` file into `~/.config/nvim/init.lua`.

## Managed Files

- `init.lua` → `~/.config/nvim/init.lua`
- `Makefile` → install and cleanup logic

## Runtime Paths

The install flow manages:

- `~/.config/nvim/`
- `~/.cache/nvim/`

## Customization

Edit the repository version of `init.lua` to change the Neovim setup. Because the file is symlinked, updates are used immediately.

## Cleanup

```bash
make -C vim clean
```

This removes the generated Neovim config and cache state, along with legacy Vim-related artifacts that are no longer part of the active setup.

## Notes

- Keep the main configuration in the repository-managed `init.lua` file.
- Use local shell or editor customizations only where needed.
- Preview changes with `make -n -C vim install` before applying them.
