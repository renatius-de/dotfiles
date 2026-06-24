# Configuration Modules

Additional system configuration that is symlinked into the home directory.

## Installation

Install all configuration modules:

```bash
make -C config install
```

## Contents

This directory currently contains:

- `spring-boot/` — Symlinked to `~/.config/spring-boot`

## Important Files

- `Makefile` — Installation and cleanup targets
- `spring-boot/` — Spring Boot configuration

## Adding New Modules

To add a new configuration module:

1. Create a subdirectory in `config/`
2. Add your configuration files
3. Update the `Makefile` to create symlinks for the new module
4. Test with `make -C config install`

## Local Overrides

For configuration-specific overrides, use local files:

- Create a `.local` file in the destination directory
- Edit the local file instead of the symlinked repository file
