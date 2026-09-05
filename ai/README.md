# AI instructions and skills module

This module installs the repository-managed instruction and skill files into the user-level directories used by GitHub Copilot, Claude, and local agent tooling.

## Purpose

The `ai/Makefile` links the repository's bundled instruction and skill content into:

- `~/.copilot/instructions`
- `~/.copilot/skills`
- `~/.claude/rules`
- `~/.claude/skills`
- `~/.agents/skills`

## Installation

Install the bundled rules and skills:

```bash
make -C ai install
```

Refresh the installed content:

```bash
make -C ai upgrade
```

Remove the installed AI configuration:

```bash
make -C ai clean
```

## Targets

- `install` — installs all instruction and skill directories
- `install-rules` — installs the rule/instruction content for Copilot and Claude
- `install-skills` — installs the skill content for Copilot, Claude, and agent tooling
- `clean` — removes the installed AI configuration directories
- `upgrade` — reruns the install flow

## Variables

- `COPILOT_DIR` — target directory, default `~/.copilot`
- `COPILOT_INSTRUCTIONS_DIR` — `$(COPILOT_DIR)/instructions`
- `COPILOT_SKILLS_DIR` — `$(COPILOT_DIR)/skills`
- `CLAUDE_DIR` — target directory, default `~/.claude`
- `CLAUDE_RULES_DIR` — `$(CLAUDE_DIR)/rules`
- `CLAUDE_SKILLS_DIR` — `$(CLAUDE_DIR)/skills`
- `AGENTS_DIR` — target directory, default `~/.agents`
- `AGENTS_SKILLS_DIR` — `$(AGENTS_DIR)/skills`
- `AI_INSTRUCTIONS_DIR` — repository source for instructions
- `AI_SKILLS_DIR` — repository source for skills

## Notes

- The module is built on the shared helpers in `make/common.mk`.
- The install flow is intentionally idempotent and replaces the managed directories with symlinks to the repository version.
