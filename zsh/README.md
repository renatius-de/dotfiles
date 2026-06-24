# Zsh Configuration

Zsh shell configuration, environment setup, and plugin management using Oh My Zsh.

## Installation

Install the Zsh configuration:

```bash
make -C zsh install
```

This installs Oh My Zsh (if needed), clones external plugins, and creates symlinks for configuration files.

## Important Files

- `zshrc` — Symlinked to `~/.zshrc` (main Zsh configuration)
- `zprofile` — Symlinked to `~/.zprofile` (login shell setup)
- `alias.zsh` — Zsh aliases
- `bundle.zsh` — Plugin bundle configuration
- `export.zsh` — Environment variable exports
- `Makefile` — Installation and cleanup targets

## External Plugins

The installation automatically clones and manages these external plugins:

- `zsh-users/zsh-autosuggestions` — Fish-like autocompletion suggestions
- `zsh-users/zsh-syntax-highlighting` — Syntax highlighting for commands
- `zsh-users/zsh-completions` — Additional completion functions
- `superbrothers/zsh-kubectl-prompt` — Kubernetes context in prompt
- `MichaelAquilina/zsh-you-should-use` — Alias reminder when typing commands

## Local Overrides

Use `~/.zshrc.local` for personal Zsh configuration:

```bash
# Custom aliases
alias ll='ls -lah'
alias grep='grep --color=auto'

# Custom functions
my_function() {
    echo "Custom function"
}
```

The main `zshrc` file sources this local file automatically.

## Oh My Zsh

Oh My Zsh is installed during the `install` target if not already present. The installation:

- Downloads and installs Oh My Zsh from the official repository
- Clones external plugins into the Oh My Zsh custom plugins directory
- Removes the default `~/.zshrc` file created by Oh My Zsh installation

## Cache and History

Zsh configuration creates and uses:

- `~/.cache/zsh/` — Cache directory for Zsh data
- `~/.zsh_history` — Command history file
- `~/.zcompdump*` — Completion cache files

## Cleanup

The `clean` target removes:

- Zsh history and cache files
- Oh My Zsh installation
- External plugin clones
- Configuration symlinks
- Legacy antigen setup

## Tips

- Edit `zshrc`, `alias.zsh`, and `export.zsh` in this repository
- Restart your shell to apply changes: `exec zsh`
- Use `~/.zshrc.local` for machine-specific configuration
- Run `make -n -C zsh install` to preview changes
- Regularly run `make -C zsh upgrade` to update plugins and Oh My Zsh
