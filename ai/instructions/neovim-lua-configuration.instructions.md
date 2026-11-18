---
name: neovim-lua-configuration
description: "Use when changing this repository's Neovim configuration written in Lua."
applyTo: "vim/**/*.lua"
---

# Neovim Lua Configuration Standards

## Scope

- Apply these rules to Lua configuration under `vim/`, including the current `vim/init.lua`.
- Preserve the existing module contract: `vim/init.lua` is linked into `~/.config/nvim/init.lua`, with Neovim state and cache kept in their established locations.
- This instruction covers editor configuration only. Follow the repository Makefile standards separately when changing installation targets.

## Required behavior

- Check the installed or project-required Neovim version before using version-specific APIs. Do not silently raise the minimum supported version.
- Prefer Neovim's documented Lua APIs and the existing `vim.opt` style for editor options. Keep configuration declarative and grouped by purpose.
- Preserve existing user-visible defaults unless the requested change calls for different behavior.
- Guard optional executables, external tools, and platform-dependent paths before using them.
- Keep configuration startup deterministic and avoid network access, interactive prompts, or expensive work during startup.
- Do not introduce a plugin manager or new plugin dependencies unless the project adopts and installs them explicitly.
- Keep temporary, undo, and cache data under Neovim's established state/cache paths; do not store generated data in the tracked configuration directory.

## Do not

- Do not use Vimscript-only APIs or assume a Vim runtime is equivalent to Neovim.
- Do not execute shell commands with interpolated user-controlled values or expose secrets through editor options, logs, or tracked files.
- Do not suppress configuration errors broadly or add fallback behavior that hides an unsupported API.
- Do not modify the installation flow or home-directory contents directly as part of an editor configuration change.

## Verification

- When Neovim is available, load the changed configuration in headless mode:

  ```bash
  nvim --headless -u vim/init.lua -c 'qa!'
  ```

- Use the repository's Makefile dry run when an installation target changes. Do not run install or clean targets as a configuration syntax check.
- If Neovim is unavailable, state that runtime configuration validation could not be run.

## Success criteria

- The configuration loads on the supported Neovim version, retains the repository's installation and state-directory conventions, and introduces no unapproved dependencies or startup side effects.
