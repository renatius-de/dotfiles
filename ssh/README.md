# SSH Configuration

Secure and optimized SSH client configuration with connection multiplexing, key management, and best practices.

## Overview

This SSH configuration provides:

- **Security**: Strict host key checking, key-only authentication, identity file management.
- **Performance**: Connection multiplexing (ControlMaster) reduces overhead for repeated connections.
- **Reliability**: Keep-alive settings (ServerAliveInterval) prevent connection timeouts.
- **Organization**: Centralized host configuration with local overrides for sensitive data.
- **Flexibility**: Template examples for development, production, and bastion host patterns.

## File Structure

| File | Purpose |
|------|----------|
| `config` | Main SSH client configuration; global defaults and host definitions |
| `config.local` | Local host-specific config (created on install, not tracked) |
| `Makefile` | Installation and cleanup targets |

## Features & Highlights

### Global Configuration

The `Host *` section sets secure defaults for all connections:

```
AddKeysToAgent yes          # Automatically add keys to ssh-agent
Compression yes             # Enable compression for slow links
ControlMaster auto          # Multiplex SSH connections
ControlPath ~/.ssh/control/%h:%p:%r
ControlPersist 600         # Keep multiplexed connections for 10 minutes
ServerAliveInterval 60      # Send keepalive every 60 seconds
ServerAliveCountMax 3       # Drop connection after 3 missed keepalives
StrictHostKeyChecking accept-new  # Accept new hosts automatically
UpdateHostKeys yes          # Update known_hosts automatically
```

### Connection Multiplexing

Multiple SSH sessions over the same connection dramatically improve performance:

```bash
# First connection establishes the master
ssh user@host

# Subsequent connections reuse the master (nearly instant)
ssh user@host
scp user@host:file .
ssftp user@host
```

Connections persist for 10 minutes (`ControlPersist 600`) after the last session closes.

### Version Control Platforms

Github, Gitlab, Bitbucket, and Gitea are pre-configured:

```
Host github.com, gitlab.com, etc.
    User git
    PasswordAuthentication no
    PubkeyAuthentication yes
```

Update `IdentityFile` entries if using non-standard key names.

### Host Organization

The config includes commented templates for:

- **Development Servers** — Standard configuration for dev environments
- **Production Servers** — Enhanced security (strict checks, alternate ports)
- **Bastion/Jump Hosts** — Proxy configuration for internal network access

Uncomment and customize these templates with your actual hostnames and credentials.

## Installation

### Quick Setup

Install SSH configuration:

```bash
make -C ssh install
```

This will:
1. Create `~/.ssh/` directory with secure permissions (0700)
2. Create `~/.ssh/control/` directory for multiplexed connections
3. Symlink `config` to `~/.ssh/config`
4. Create `~/.ssh/config.local` for personal overrides
5. Set correct file permissions (0600 for config)

### Dry Run

Preview changes without executing:

```bash
make -n -C ssh install
```

## Customization

### Local Host Configuration

Add host-specific settings to `~/.ssh/config.local` (not tracked):

```bash
Host dev-server
    Hostname dev.internal.example.com
    User devuser
    IdentityFile ~/.ssh/keys/dev_key

Host prod-server
    Hostname prod.internal.example.com
    User produser
    Port 2222
    IdentityFile ~/.ssh/keys/prod_key
    ProxyJump bastion

Host bastion
    Hostname bastion.example.com
    IdentityFile ~/.ssh/keys/bastion_key
```

The main `config` automatically includes this local file.

### Custom Key Organization

Organize keys in `~/.ssh/keys/` by environment:

```bash
~/.ssh/keys/
├── github_personal
├── gitlab_work
├── dev_server
├── prod_server
└── bastion
```

Reference them in config:

```bash
Host github.com
    IdentityFile ~/.ssh/keys/github_personal

Host prod-server
    IdentityFile ~/.ssh/keys/prod_server
```

## Security

### File Permissions

SSH files are created with secure permissions:

| Path | Permissions | Owner |
|------|-------------|-------|
| `~/.ssh/` | 0700 | user only |
| `~/.ssh/config` | 0600 | user only |
| `~/.ssh/config.local` | 0600 | user only |
| `~/.ssh/known_hosts` | 0600 | user only |

### Best Practices

- Keep private keys in `~/.ssh/keys/` with restricted permissions (0600)
- Never commit private keys to version control
- Use `IdentityFile` to explicitly list allowed keys per host
- Enable `StrictHostKeyChecking yes` for production servers
- Rotate SSH keys periodically
- Review `~/.ssh/known_hosts` and `~/.ssh/config.local` regularly

## Maintenance

### Verify Configuration

Test SSH configuration syntax:

```bash
ssh -G hostname  # Show effective config for hostname
ssh -v user@host # Verbose output (useful for debugging)
```

### Clean Up

```bash
make -C ssh clean
```

Removes SSH symlinks and local config overrides.

## Tips

- **Test Connections**: Use `ssh -T git@github.com` to verify key-based authentication
- **SSH Agent**: `ssh-add ~/.ssh/keys/key_name` to load keys into the agent
- **Connection Pooling**: Use `ssh -O check user@host` to verify a multiplexed connection is active
- **Close Multiplexed Connection**: `ssh -O exit user@host` terminates the master connection
- **Proxy Configuration**: Use `ProxyJump` (newer) instead of deprecated `ProxyCommand`
- **Known Hosts**: `ssh-keyscan -H hostname >> ~/.ssh/known_hosts` to add hosts without interactive prompt

