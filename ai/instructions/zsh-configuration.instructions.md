---
name: zsh-configuration
description: "Use when changing this repository's Zsh startup files, shell components, aliases, or environment settings."
applyTo: "zsh/*.zsh,zsh/zshrc,zsh/zprofile"
---

# Zsh Configuration Standards

## Scope

Apply to repository-managed `zsh/` interactive configuration. Preserve the `zshrc`, `zprofile`, component, and user-owned `~/.zshrc.local` split. For installation targets, also follow repository Makefile standards.

## Required behavior

- Identify login/interactive/non-interactive effects; preserve `zshrc`'s early interactive guard and keep login setup in `zprofile`.
- Preserve `bundle`, `alias`, `export` order and load the local override after managed settings unless behavior change is requested.
- Use Zsh syntax and semantics; do not assume Bash syntax or options are interchangeable.
- Quote expansions when they represent paths or arguments. Preserve intentional Zsh array, glob, and parameter-expansion behavior.
- Guard optional commands, plugins, and platform-specific settings so a missing tool or unsupported operating system does not break shell startup.
- Keep secrets and machine-specific values out of tracked files. Use the existing local override for host-specific settings.
- Avoid expensive work, network access, and startup prompts unless existing behavior or the task requires them.

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
