# Copilot instructions module

This module installs the repository-managed Copilot instruction file into the expected user-level location so editors and tooling can pick it up automatically.

## Purpose

The `copilot/Makefile` creates the `~/.copilot/instructions` directory and links `global-copilot-instructions.md` into it.

## Installation

Install the symlink:

```bash
make -C copilot install
```

Create only the link target:

```bash
make -C copilot link
```

Remove the installed symlink:

```bash
make -C copilot clean
```

## Targets

- `install` — creates the directories and links the instructions file
- `link` — creates the single symlink target
- `clean` — removes the installed local instruction file

## Variables

- `COPILOT_DIR` — target directory, default `~/.copilot`
- `COPILOT_INSTRUCTIONS_DIR` — `$(COPILOT_DIR)/instructions`
- `COPILOT_INSTRUCTIONS_FILE` — final destination for the symlink
- `SOURCE_INSTRUCTIONS_FILE` — repository source file

## Notes

- The module is built on the shared helpers in `make/common.mk`.
- The link step is idempotent and safe to run repeatedly.
