---
name: zsh-configuration
description: "Use when changing this repository's Zsh startup files, shell components, aliases, or environment settings."
applyTo: "zsh/*.zsh,zsh/zshrc,zsh/zprofile"
---

# Zsh Configuration Standards

## Scope

- Apply these rules to the repository-managed files in `zsh/` that configure interactive Zsh sessions.
- Preserve the existing split between `zshrc`, `zprofile`, component files, and the user-owned `~/.zshrc.local` override.
- This instruction covers Zsh configuration behavior only. Follow the repository Makefile standards separately when changing installation targets.

## Required behavior

- Confirm whether a change runs in login, interactive, or non-interactive shells. Preserve the early interactive-shell guard in `zshrc` and keep login setup in `zprofile`.
- Preserve the configured component load order (`bundle`, `alias`, `export`) and load the local override after repository-managed settings unless the user requests a behavior change.
- Use Zsh syntax and semantics; do not assume Bash syntax or options are interchangeable.
- Quote expansions when they represent paths or arguments. Preserve intentional Zsh array, glob, and parameter-expansion behavior.
- Guard optional commands, plugins, and platform-specific settings so a missing tool or unsupported operating system does not break shell startup.
- Keep secrets and machine-specific values out of tracked files. Use the existing local override for host-specific settings.
- Avoid expensive work, network access, and interactive prompts during shell startup unless the current behavior or task requires them.

## Do not

- Do not overwrite or remove user-owned local configuration while changing repository files.
- Do not move interactive-only commands into `zprofile` or other non-interactive startup paths.
- Do not add a dependency, plugin, or shell option without verifying it is available and compatible with the supported macOS/Linux environments.
- Do not suppress startup failures broadly; report or guard only the specific optional operation that can fail.

## Verification

- Run the repository's syntax check for all Zsh configuration files:

  ```bash
  for file in zsh/*.zsh zsh/zprofile zsh/zshrc; do
    zsh -n "$file"
  done
  ```

- When changing load order or startup behavior, verify the affected flow in a clean, non-interactive or isolated Zsh process as appropriate. Do not source personal local overrides as a substitute for repository-level validation.
- If Zsh is unavailable, state that syntax validation could not be run.

## Success criteria

- The change preserves intended login and interactive startup behavior, does not require unverified tools, and passes the relevant Zsh syntax checks.
