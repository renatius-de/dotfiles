# Zsh Configuration

This module manages the shell configuration for Zsh, including the main startup files, plugin setup, and local overrides.

## Installation

```bash
make -C zsh install
```

The target installs Oh My Zsh when needed, clones configured plugins, and creates the required symlinks for the user shell configuration.

## Managed Files

- `zshrc` → `~/.zshrc`
- `zprofile` → `~/.zprofile`
- `alias.zsh` → shared aliases
- `bundle.zsh` → plugin setup
- `export.zsh` → environment exports
- `Makefile` → install and cleanup logic

## External Plugins

The module automatically maintains the following plugins:

- `zsh-users/zsh-autosuggestions`
- `zsh-users/zsh-syntax-highlighting`
- `zsh-users/zsh-completions`
- `superbrothers/zsh-kubectl-prompt`
- `MichaelAquilina/zsh-you-should-use`

## Local Overrides

Use `~/.zshrc.local` for machine-specific settings:

```bash
alias ll='ls -lah'
alias grep='grep --color=auto'

custom_tool() {
    echo "Custom shell logic"
}
```

The main `zshrc` file loads this override file when it exists.

## Cache and History

The installation creates or manages:

- `~/.cache/zsh/`
- `~/.zsh_history`
- completion dump files under `$HOME`

## Cleanup

```bash
make -C zsh clean
```

This removes generated cache files, plugin directories, and symlinks created by the module.

## Notes

- Edit the repository copies of the Zsh files rather than the installed symlink target.
- Reload the shell with `exec zsh` after making configuration changes.
- Use `make -n -C zsh install` to preview changes before running them.
