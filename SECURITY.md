# Security

This repository contains personal dotfiles and shell setup scripts for macOS and Linux. Because it manages SSH configuration, package installation, and local environment setup, it should be reviewed carefully before use on a real system.

## Reporting Security Issues

If you discover a security problem, please report it responsibly:

1. Do not open a public issue for sensitive vulnerabilities.
2. Use GitHub’s private [security advisory process](https://github.com/renatius-de/dotfiles/security/advisories).
3. Include a clear description of the issue, affected files or commands, and reproduction steps.
4. Allow time for maintainers to assess and respond before public disclosure.

## Repository Security Practices

- Automated security scanning is configured in `.github/workflows/security-scan.yml`.
- Changes are reviewed before being merged into the default branch.
- Dependencies and tooling are maintained periodically.

## Best Practices for Local Use

- Review shell scripts and configuration before running them on a machine.
- Store sensitive data in local override files such as `~/.gitconfig.local` or `~/.ssh/config.local`.
- Never commit private keys, tokens, or credentials.
- Keep the environment updated with `make upgrade` after reviewing new changes.

## Contact

For security-related questions or reports, use the private GitHub security advisory flow or contact the repository maintainers directly.
