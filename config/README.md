# Configuration Modules

This module provides additional configuration content that is linked into `$HOME` so it can be versioned and managed in the repository.

## Installation

```bash
make -C config install
```

## Current Content

This directory currently includes:

- `spring-boot/` → `~/.config/spring-boot`

## Files

- `Makefile` — install and cleanup logic
- `spring-boot/` — Spring Boot configuration files

## Adding a New Module

To add another configuration module:

1. create the source directory under `config/`
2. add the required configuration files
3. update the `Makefile` to link the new directory into the target location
4. validate with `make -C config install`

## Local Overrides

For machine-specific adjustments, prefer a local file in the target location instead of editing the repository-managed file directly.
