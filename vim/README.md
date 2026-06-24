# Neovim Configuration

Neovim (Nvim) configuration files written in Lua.

## Installation

Install the Neovim configuration:

```bash
make -C vim install
```

This creates the necessary directories and symlinks the Neovim config file.

## Important Files

- `init.lua` — Symlinked to `~/.config/nvim/init.lua` (main Neovim configuration)
- `Makefile` — Installation and cleanup targets

## Configuration Structure

The installation creates and manages:

- `~/.config/nvim/` — Neovim configuration directory
- `~/.config/nvim/init.lua` — Main Neovim configuration (symlinked from this repo)
- `~/.cache/nvim/` — Cache directory for Neovim plugins and data

## Customization

To customize Neovim configuration:

1. Edit `init.lua` in this repository
2. Changes are reflected immediately in Neovim (via symlink)
3. Use Neovim commands to reload configuration: `:luafile ~/.config/nvim/init.lua`

## Clean Up

The `clean` target removes:

- Vim-related files: `.vimrc`, `.vim/`, `.viminfo`, etc.
- Neovim-related directories: `~/.config/nvim/`, `~/.cache/nvim/`, etc.
- Plugin manager data: `dein.nvim`, `dein.vim`, etc.

## Related Editors

The `clean` target also removes legacy Vim and Vi configuration:

- `.vim/` — Vim configuration directory
- `.vimrc` — Vim configuration file
- `.vimpagerrc` — Vimpager configuration
- `.vimoutlinerrc` — VimOutliner configuration

## Tips

- Keep plugin management configuration in `init.lua` for consistency
- Use symlinks instead of copying configuration files
- Test configuration changes before committing
- Run `make -n -C vim install` to preview changes
