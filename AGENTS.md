# AI Agent Guidance

This document provides guidance for AI assistants maintaining and extending the `renatius-de/dotfiles` repository.

## Purpose

Personal dotfiles and installation scripts for macOS and Linux. The repository uses symlink-based configuration
modules and Makefile-driven orchestration to manage system setup.

## Key Facts

- Configuration files are stored in this repository and symlinked into the user home directory.
- Each module has its own `Makefile` under `zsh/`, `vim/`, `git/`, `ssh/`, `misc/`, and `config/`.
- The root `Makefile` manages Homebrew package installation and coordinates module-level targets.
- This is a personal configuration repository, not a full application stack.
- Avoid assumptions beyond Homebrew, Zsh, Vim/Neovim, Git, and SSH tooling.

## Important Paths

- `.github/workflows/security-scan.yml` — CI/CD security scanning
- `Makefile` — Root-level orchestration
- `README.md` — Overview and quick-start guide
- `docs/MAKEFILE.md` — Makefile documentation
- `config/` — Additional configuration modules
- `git/` — Git configuration and templates
- `misc/` — Utility scripts and Java configuration
- `ssh/` — SSH configuration and key management
- `vim/` — Neovim configuration
- `zsh/` — Zsh configuration and plugin setup
- `make/` — Shared Makefile utilities and functions

## Recommended Commands

```bash
make install              # Install all modules and Homebrew packages
make upgrade              # Upgrade all modules and packages
make -C zsh install      # Install Zsh configuration
make -C vim install      # Install Neovim configuration
make -C git install      # Install Git configuration
make -n install          # Dry-run: preview without executing
```

## Best Practices

- **Avoid destructive edits** to the user home directory.
- **Keep changes focused** on the relevant module and its `Makefile`.
- **Prefer editing repository files** and symlink logic over adding unrelated scripts.
- **Use existing docs** instead of duplicating information.
- **Test changes** with `make -n` before committing.
- **Maintain consistency** across all Makefiles and documentation.

## Scope

- Makefile orchestration and top-level configuration
- Module directories: `zsh/`, `vim/`, `git/`, `ssh/`, `misc/`, `config/`
- Documentation: `README.md`, `AGENTS.md`, `docs/`, module READMEs
- Non-destructive repository changes only

## When to Use This Repository

- Updating installation and symlink logic
- Adding or refining module documentation and make targets
- Fixing repository structure, docs, or shell configuration
- Optimizing Makefiles for consistency and maintainability

## Example Use Cases

- "Update the `zsh` module to support a safe dry-run mode."
- "Add a README section explaining how to install individual modules."
- "Fix the root `Makefile` to ensure `make upgrade` refreshes all modules."
- "Normalize all Markdown files for consistent formatting and structure."

## Related Documentation

- [README.md](README.md) — Project overview
- [CONTRIBUTING.md](CONTRIBUTING.md) — Contribution guidelines
- [SECURITY.md](SECURITY.md) — Security policies
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) — Community guidelines
- [docs/MAKEFILE.md](docs/MAKEFILE.md) — Makefile details
