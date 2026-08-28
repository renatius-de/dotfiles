# Neovim configuration

This module manages the repository version of the Neovim configuration and links it into the standard user configuration directory.

## Installation

```bash
make -C vim install
```

The install target ensures the required directories exist and links the repository `init.lua` file into `~/.config/nvim/init.lua`.

## Managed files

- `init.lua` → `~/.config/nvim/init.lua`
- `Makefile` → install and cleanup logic

## Runtime paths

The install flow manages:

- `~/.config/nvim/`
- `~/.cache/nvim/`

## Customization

Edit the repository version of `init.lua` to change the Neovim setup. Because the file is installed as a symlink, changes are applied immediately.

## Cleanup

```bash
make -C vim clean
```

This removes the generated Neovim state and any legacy Vim-related artifacts that are no longer part of the active setup.

## Notes

- Keep the main configuration in the repository-managed `init.lua` file.
- Use local shell or editor customizations only where they are truly necessary.
- Preview changes with `make -n -C vim install` before applying them.
