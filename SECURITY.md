# Security

This repository contains personal dotfiles and installation scripts for macOS and Linux environments.

## Reporting Security Issues

If you discover a security vulnerability, please report it responsibly:

1. **Do not** open a public issue on GitHub.
2. Use GitHub's [Security Advisory](https://github.com/renatius-de/dotfiles/security/advisories)
   feature to report privately.
3. Include a clear description of the vulnerability and steps to reproduce it.
4. Allow time for a response before public disclosure.

## Security Measures

- Automated security scanning is performed via `.github/workflows/security-scan.yml`.
- All code is reviewed before merging into the main branch.
- Dependencies are kept up to date with regular maintenance.

## Best Practices

When using this repository:

- Review all scripts and configuration before running them on your system.
- Use local override files (e.g., `~/.gitconfig.local`) for sensitive personal information.
- Keep your SSH keys secure and never commit them to this repository.
- Regularly update your system and dependencies using `make upgrade`.

## Security Contact

For security-related inquiries, please use the GitHub Security Advisory feature or contact the maintainers privately.
