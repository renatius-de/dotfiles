# Configuration module

This module links repository-managed configuration into the user's home directory so it can be versioned and reinstalled consistently.

## Installation

```bash
make -C config install
```

## Managed content

The current module installs the Spring Boot configuration directory into the user config location:

- `spring-boot/` → `~/.config/spring-boot`

## Files

- `Makefile` — install and cleanup logic
- `spring-boot/` — Spring Boot configuration content

## Adding another module

When adding a new configuration bundle:

1. create the source directory under `config/`
2. add the required files
3. update the `Makefile` to link the directory to its target path
4. verify with `make -C config install`

## Local overrides

For machine-specific changes, prefer a local override inside the target directory instead of editing the repository-managed file directly.
