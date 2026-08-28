# SSH configuration

This module installs the repository-managed SSH client configuration and leaves room for private override values specific to each machine.

## Installation

```bash
make -C ssh install
```

The install target creates:

- `~/.ssh/` with secure permissions
- `~/.ssh/control/` for multiplexed SSH sessions
- a symlinked `~/.ssh/config`
- a local override file at `~/.ssh/config.local`

## Managed files

- `config` → `~/.ssh/config`
- `config.local` → `~/.ssh/config.local`
- `Makefile` → install and cleanup logic

## Included defaults

The shipped SSH config includes safe defaults such as:

- strict host key checking
- connection multiplexing via `ControlMaster`
- keepalive settings
- agent integration for key-based authentication

This keeps the default behavior secure and practical for regular developer work.

## Local overrides

Add host-specific rules in `~/.ssh/config.local`:

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

The main config includes this file when it exists.

## Key management

Store private keys in a dedicated directory such as:

```bash
~/.ssh/keys/
```

This keeps secrets separate from the shared configuration.

## Verification and cleanup

Check the effective SSH configuration:

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
- Prefer `IdentityFile` entries per host instead of broad credential defaults.
- Use `ProxyJump` for bastion-based workflows when appropriate.

