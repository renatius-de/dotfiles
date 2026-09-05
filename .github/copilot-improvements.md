# GitHub Copilot Improvement Opportunities

This document analyses the repository's current Copilot context and proposes focused improvements. The recommendations are based on the repository layout, existing AI assets, Makefiles, documentation, and GitHub automation.

## Current Context

The repository already provides useful AI guidance:

- `AGENTS.md` describes the repository purpose, module boundaries, safe editing rules, and common commands.
- `ai/instructions/` contains reusable instructions for code quality, documentation, Java, OpenAPI, and execution behavior.
- `.github/instructions/makefile-standards.instructions.md` provides repository-specific Makefile rules.
- `ai/skills/` and `.github/skills/` provide focused workflows for Java, OpenAPI, README, and Makefile tasks.
- `docs/MAKEFILE.md`, `CONTRIBUTING.md`, and module README files document installation and validation workflows.

There are nevertheless several gaps that reduce Copilot's repository-specific context:

1. No root-level `.github/copilot-instructions.md` consolidates the repository contract for Copilot.
2. No repository-local prompt templates or custom slash-command prompts exist.
3. Validation is primarily based on Makefile dry runs; there is no dedicated aggregate target for AI-asset, Markdown, shell, and Makefile checks.
4. The shell, Makefile, and configuration interfaces are implicit. Their variables, side effects, platform assumptions, and safety boundaries are distributed across implementation and README files rather than described in one concise reference.
5. The repository has no conventional application type system. This is appropriate for dotfiles, but typed interfaces can still be added for structured configuration, environment variables, and machine-readable validation results.

## Priority Summary

| Priority | Recommendation | Expected benefit |
| --- | --- | --- |
| P1 | Add `.github/copilot-instructions.md` | Gives Copilot one concise repository contract for recurring changes. |
| P1 | Add focused prompt templates under `.github/prompts/` | Makes common maintenance tasks repeatable and improves request completeness. |
| P1 | Add a safe `make verify` target | Gives Copilot an executable, discoverable validation command. |
| P2 | Add an AI context map and module contracts | Reduces incorrect assumptions about ownership, side effects, and local overrides. |
| P2 | Add lightweight linting for Makefiles, shell, and Markdown | Converts implicit style rules into machine-checkable feedback. |
| P3 | Emit structured audit results | Makes automated review easier to consume in CI and future Copilot prompts. |

## 1. Add a Root Copilot Instruction File

### Finding: missing central contract

`AGENTS.md` is useful general guidance, but it is not a concise Copilot-specific contract. The repository has a Makefile instruction under `.github/instructions/`, while cross-module rules remain distributed across `AGENTS.md`, `docs/MAKEFILE.md`, and module READMEs.

### Recommendation: add a concise project contract

Create `.github/copilot-instructions.md` with only stable repository-wide rules. Keep detailed domain rules in the existing instruction and skill files to avoid duplication.

### Example

```markdown
# Repository Copilot Instructions

## Scope

This repository contains personal macOS and Linux dotfiles managed through GNU Make and symlinks.

## Before editing

- Identify the owning module and read its Makefile and README.
- Read `make/common.mk` before changing shared Make behavior.
- Preserve symlink-based installation and local override files.
- Treat `clean` as potentially destructive; use `make -n` first.

## Implementation rules

- Keep changes module-local unless shared behavior is genuinely affected.
- Reuse helpers from `make/common.mk` instead of duplicating shell logic.
- Preserve target names, dependency order, status output, and failure handling.
- Do not edit files under `$HOME` directly when a repository source file exists.
- Do not expose secrets, credentials, private keys, or machine-specific paths in tracked files.

## Validation

- Run `make -n <target>` for the affected target.
- Run `make -n install` for changes that affect root orchestration.
- Run `python3 ai/audit_assets.py` when changing AI instructions, skills, or prompts.
- Report commands that were not run and why.
```

### Design rule

Do not copy all of `AGENTS.md` into this file. The Copilot file should establish precedence and the shortest reliable workflow, while `AGENTS.md` remains the broader agent reference.

## 2. Add Prompt Templates

### Finding: no reusable prompt entry points

No repository-local prompt templates were found. Contributors therefore need to restate the same repository constraints for common tasks such as Makefile changes, module maintenance, and AI-asset updates.

### Recommendation: add focused prompt files

Add `.github/prompts/` with small, task-specific prompt files. Keep prompts operational and require evidence rather than broad explanations.

### Suggested prompt set

| Prompt | Use case |
| --- | --- |
| `review-makefile.prompt.md` | Review target graph, side effects, portability, and dry-run coverage. |
| `change-module.prompt.md` | Implement a focused change in one dotfiles module. |
| `audit-ai-assets.prompt.md` | Audit instructions, skills, and prompts and update the generated report. |
| `review-install-safety.prompt.md` | Inspect symlink, cleanup, download, privilege, and secret-handling risks. |

### Example: `.github/prompts/review-makefile.prompt.md`

```markdown
---
name: review-makefile
description: Review a repository Makefile for correctness, safety, and compatibility.
---

Review the selected Makefile and its nearest caller.

Check:

- target ownership, dependencies, and `.PHONY` declarations
- reuse of helpers from `make/common.mk`
- shell strictness, quoting, exit status, and error messages
- symlink, cleanup, download, privilege, and environment-variable side effects
- compatibility with `install`, `upgrade`, `clean`, and documented commands

Run the narrowest safe `make -n` check. Report findings first with file references and severity. Do not modify files unless explicitly requested.
```

Prompt files should reference repository commands and boundaries directly. They should not repeat generic coding advice already covered by the instruction assets.

## 3. Add a Discoverable Verification Target

### Finding: no aggregate verification command

The repository documents `make -n install` and module-specific dry runs, and the AI asset audit is run directly with Python. There is no single verification command that Copilot can discover and execute safely.

### Recommendation: add a safe verification target

Add a non-destructive `verify` target to the root Makefile. It should validate repository structure and dry-run the relevant Makefile flows without installing packages or changing `$HOME`.

### Example: root verification target

```make
.PHONY: verify

verify:
<TAB>$(call target_start,verify)
<TAB>@python3 ai/audit_assets.py
<TAB>@$(MAKE) -n install >/dev/null
<TAB>@$(MAKE) -n upgrade >/dev/null
<TAB>@$(MAKE) -n clean >/dev/null
<TAB>$(call target_end,verify)
```

Replace each `<TAB>` marker with one literal tab in the Makefile. Make recipes require literal tabs even though this documentation uses a visible marker to remain Markdown-lint friendly.

The target should be added only after confirming that every dry run remains side-effect free. If the root dry run evaluates environment-sensitive commands, split the target into explicit checks and document the limitation.

## 4. Make Quality Checks Explicit

### Finding: checks are mostly implicit

The repository contains shell, Zsh, Lua, Python, YAML, Markdown, and GNU Make files. `.editorconfig` defines useful formatting rules, but most syntax and style expectations are not executable checks. The security workflow runs Codacy, but it does not provide a focused local validation command for repository maintenance.

### Recommendation: make checks executable

Add optional checks incrementally, using tools already available in the supported environments:

- GNU Make parse/dry-run checks for every module
- ShellCheck for `.sh` and `.bash` files where supported
- `zsh -n` for Zsh scripts
- a Lua parser or formatter check for `vim/init.lua`
- Markdown link/frontmatter checks
- YAML parsing for GitHub workflows and instruction metadata

Keep these checks separate from destructive installation targets. A useful structure is:

```text
make verify          # aggregate, non-destructive checks
make verify-make     # Makefile parse and dry runs
make verify-ai       # ai/audit_assets.py and metadata checks
make verify-shell    # shell and Zsh syntax checks
```

Do not add a tool merely because it is popular. Pin or document the tool requirement and ensure the check can run on macOS and Linux.

## 5. Add an AI Context Map

### Finding: ownership is distributed

Module ownership is documented in several places, but Copilot must infer which files are authoritative and which files are generated or local. This is especially important for symlink targets and local override files.

### Recommendation: add an ownership map

Add `docs/AI_CONTEXT.md` or a section in `AGENTS.md` containing a compact ownership table.

### Example: ownership map

```markdown
| Area | Source of truth | Installed target | Safe validation |
| --- | --- | --- | --- |
| Git | `git/config`, `git/ignore` | `~/.gitconfig`, `~/.gitignore` | `make -n -C git install` |
| SSH | `ssh/config` | `~/.ssh/config` | `make -n -C ssh install` |
| Zsh | `zsh/*.zsh`, `zsh/zshrc` | `~/.zsh*`, `~/.zsh/` | `make -n -C zsh install` |
| Neovim | `vim/init.lua` | `~/.config/nvim/init.lua` | `make -n -C vim install` |
| AI assets | `ai/instructions/`, `ai/skills/` | user-level agent directories | `python3 ai/audit_assets.py` |
```

Also list local-only files such as `~/.gitconfig.local`, `~/.ssh/config.local`, and `~/.zshrc.local`. This prevents Copilot from placing machine-specific values in tracked files.

## 6. Improve Configuration and Environment Typing

### Finding: configuration interfaces are implicit

The repository is intentionally shell- and Makefile-oriented, so conventional application type definitions are not expected. However, important interfaces are currently implicit:

- `WORK_ENV` is a string flag with a default of `false`.
- `STORE_PASS` is a sensitive environment variable with a default in `misc/Makefile`.
- `CORRETTO_VERSIONS` and `NODE_LTS_VERSIONS` are version lists.
- Homebrew, `jenv`, `sudo`, `keytool`, `nvm`, and external Git repositories are runtime dependencies.

### Recommendation: document configuration types

Document these interfaces in a machine-readable or strongly structured form where practical, without introducing a general-purpose application framework. For example:

```yaml
# docs/configuration.schema.yaml
variables:
  WORK_ENV:
    type: boolean-string
    default: "false"
    allowed: ["true", "false"]
    affects: ["Makefile", "misc/Makefile"]
  STORE_PASS:
    type: secret
    required_for: ["misc/import-ca-certs"]
    tracked_value: false
```

The schema is documentation unless a validator is added. Do not store real passwords or certificates in the repository. The existing `STORE_PASS ?= changeit` default should be reviewed because it is a credential-like default and can lead to unsafe assumptions; prefer requiring an explicit value for certificate import or clearly limiting the default to a disposable local workflow.

## 7. Add Focused Copilot Workflows

### Recommended review sequence

For a normal change, Copilot should follow this sequence:

1. Identify the owning module and its Makefile.
2. Read `make/common.mk` and the module README.
3. State the expected behavior and side effects before editing.
4. Make the smallest module-local change.
5. Run the narrowest dry run or syntax check.
6. Run the aggregate `verify` target when available.
7. Report skipped checks and potential `$HOME` or network effects.

### Example request template

```text
Change module: <module>
Goal: <observable behavior>
Constraints: preserve symlinks, local overrides, target names, and idempotency
Validation: run the narrowest safe make dry run first
Risk areas: <filesystem | network | credentials | sudo | platform>
Do not modify: unrelated modules and files under $HOME
```

This template gives Copilot the missing dimensions that are most important in this repository: ownership, side effects, compatibility, and validation evidence.

## 8. Suggested Implementation Order

### Phase 1: low risk

1. Add `.github/copilot-instructions.md` using stable rules from `AGENTS.md` and `.github/instructions/makefile-standards.instructions.md`.
2. Add the four prompt templates under `.github/prompts/`.
3. Link the new files from `ai/README.md` or the repository documentation after their locations are finalized.

### Phase 2: executable context

1. Add non-destructive `verify-ai` and `verify-make` targets.
2. Add a root `verify` target after confirming dry-run behavior.
3. Add CI execution for the non-destructive checks on pull requests.

### Phase 3: deeper consistency

1. Add the module ownership/context map.
2. Decide whether `docs/configuration.schema.yaml` should be validated automatically.
3. Add shell, Markdown, and YAML checks only where tool availability and cross-platform behavior are established.

## Explicit Non-Recommendations

- Do not duplicate every existing instruction in a new Copilot file.
- Do not install or run destructive Make targets from a Copilot verification workflow.
- Do not add broad architecture abstractions to a dotfiles repository.
- Do not introduce Java, TypeScript, or JSON schemas for files that are not data contracts.
- Do not commit credentials, private keys, local hostnames, or machine-specific paths to improve Copilot context.

## Expected Outcome

The highest-value improvement is a small, stable Copilot contract plus repeatable prompts and a safe verification target. These changes would give Copilot better context about module ownership, symlink side effects, local overrides, supported validation commands, and security boundaries without turning the repository into a framework-heavy project.
