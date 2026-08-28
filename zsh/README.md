# Zsh configuration

This module manages the local Zsh setup, including the main startup files, plugin bootstrap, aliases, exports, and local override handling.

## Installation

```bash
make -C zsh install
```

The target installs Oh My Zsh when needed, clones the configured external plugins, and creates the required symlinks for the user shell configuration.

## Managed files

- `zshrc` → `~/.zshrc`
- `zprofile` → `~/.zprofile`
- `alias.zsh` → shared aliases
- `bundle.zsh` → plugin setup
- `export.zsh` → exported environment variables
- `Makefile` → install and cleanup logic

## External plugins

The module automatically maintains the following plugins:

- `zsh-users/zsh-autosuggestions`
- `zsh-users/zsh-syntax-highlighting`
- `zsh-users/zsh-completions`
- `superbrothers/zsh-kubectl-prompt`
- `MichaelAquilina/zsh-you-should-use`

## Local overrides

Use `~/.zshrc.local` for machine-specific settings:

```bash
alias ll='ls -lah'
alias grep='grep --color=auto'

custom_tool() {
    echo "Custom shell logic"
}
```

The main `zshrc` file loads this override file when it exists.

## Cache and history

The install flow manages:

- `~/.cache/zsh/`
- `~/.zsh_history`
- completion dump files under `$HOME`

## Cleanup

```bash
make -C zsh clean
```

This removes generated cache files, plugin directories, and symlinks created by the module.

## Notes

- Edit the repository copies of the Zsh files instead of the installed symlink target.
- Reload the shell with `exec zsh` after making configuration changes.
- Preview changes with `make -n -C zsh install` before running the full install.
