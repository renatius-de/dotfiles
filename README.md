# Public Dotfiles

Collection of personal configuration files and install scripts for quickly setting up a development environment.

## Overview
This repository contains configurations for:
- Zsh (Antigen, aliases, PATH, prompt) — zsh/Makefile, zsh/zshrc  
- Vim/Neovim — vim/Makefile, vim/vimrc, vim/nvimrc  
- Git configurations — git/Makefile, git/config  
- SSH setup — ssh/Makefile, ssh/config  
- Utility scripts (Java/CACerts, Brew tasks) — misc/Makefile  
- Container linter (local via Docker Compose) — docker-compose.yml

CI / Automation:
- Security scan workflow — .github/workflows/security-scan.yml  
- Super-Linter configuration — .github/super-linter.env  
- Dependabot — .github/dependabot.yml

## Prerequisites
- macOS or Linux with standard Unix tools
- Homebrew (for Make tasks). See the top-level Makefile for the list of formulas and casks.

## Installation
1. Clone the repository.
2. From the repository root run:
   - Full install: make install  
     (calls the respective sub-makefiles — Makefile)
   - Individual components: e.g. `make -C zsh install` or `make -C vim install`

For Homebrew-specific steps see the Makefile targets: `brew-ensure`, `brew-install`, `brew-upgrade`.

## Usage
After installation, configuration files are created as symlinks in your home directory. Make local adjustments, for example `~/.gitconfig.local` or `~/.ssh/config.local`.

To run the linter locally:
- docker-compose up (uses docker-compose.yml)

## Contributing & Guidelines
- Code of Conduct: CODE_OF_CONDUCT.md  
- Contribution guidelines: CONTRIBUTING.md

## License
This project is licensed under the MIT License: LICENSE

If you need help customizing specific modules, open the relevant file (for example zsh/zshrc or vim/vimrc) and adjust settings as needed.
