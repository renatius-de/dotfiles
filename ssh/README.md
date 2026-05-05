# ssh

Install the SSH configuration with:

- `make -C ssh install`

The `Makefile` targets symlink the SSH configuration to `~/.ssh/config`.

Important files:
- `config`
- `Makefile`

Use `~/.ssh/config.local` for host-specific overrides.
