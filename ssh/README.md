# SSH Configuration

This module provides the global SSH client configuration used by the system. It sets safe defaults, enables connection multiplexing, and leaves room for private machine-specific overrides.

## Installation

```bash
make -C ssh install
```

The install target creates:

- `~/.ssh/` with secure permissions
- `~/.ssh/control/` for multiplexed SSH sessions
- a symlinked `~/.ssh/config`
- a local override file at `~/.ssh/config.local`

## Managed Files

- `config` → `~/.ssh/config`
- `config.local` → `~/.ssh/config.local`
- `Makefile` → install and cleanup rules

## Included Defaults

The shipped SSH config applies safe client settings such as:

- strict host key checking
- multiplexed connections via `ControlMaster`
- keepalive settings
- agent integration for key-based authentication

This keeps the default behavior secure and practical for regular developer workflows.

## Local Overrides

Add machine-specific settings in `~/.ssh/config.local`:

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
```

The main config is designed to include this file when present.

## Key Management

Keep keys in a dedicated directory such as:

```bash
~/.ssh/keys/
```

This helps keep private keys organized and separate from the main shared configuration.

## Verification and Cleanup

Check SSH config behavior:

```bash
ssh -G github.com
ssh -T git@github.com
```

Remove generated SSH state:

```bash
make -C ssh clean
```

## Notes

- Keep private keys out of version control.
- Prefer `IdentityFile` entries per host instead of broad default credentials.
- Use `ProxyJump` for bastion-style workflows when appropriate.

