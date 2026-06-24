# SSH Configuration

SSH configuration and key management for secure remote connections.

## Installation

Install the SSH configuration:

```bash
make -C ssh install
```

This creates directories and symlinks for SSH configuration in `~/.ssh`.

## Important Files

- `config` — Symlinked to `~/.ssh/config` (SSH client configuration)
- `Makefile` — Installation and cleanup targets

## Directory Structure

The installation creates:

- `~/.ssh/` — SSH directory (created if missing)
- `~/.ssh/config` — SSH client configuration (symlinked from this repo)
- `~/.ssh/config.local` — Host-specific overrides (created if missing)
- `~/.ssh/keys/` — SSH keys directory (created if missing)

## Local Overrides

Use `~/.ssh/config.local` for host-specific SSH configuration:

```bash
Host internal-server
    Hostname 192.168.1.100
    User myuser
    IdentityFile ~/.ssh/keys/internal_key
```

The main `config` file includes this local file automatically.

## Permissions

SSH files are created with secure permissions:

- Config files: `0600` (readable and writable by owner only)
- SSH directory: `0700` (accessible by owner only)

## Best Practices

- Keep SSH keys in `~/.ssh/keys/` with descriptive names
- Use `~/.ssh/config` to organize frequently-used hosts
- Never commit private keys to version control
- Regularly review and update your SSH configuration
