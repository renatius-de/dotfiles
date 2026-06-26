# Contributing

Contributions are welcome! Please follow these guidelines to maintain the quality and consistency of this project.

## How to Contribute

1. **Fork the Repository** — Create a personal fork of the repository.
2. **Create a Branch** — Use a descriptive branch name: `feature/module-name` or `fix/issue-description`.
3. **Make Changes** — Keep dotfiles and installation scripts minimal and deliberate.
4. **Test Locally** — Run `make -n` to verify your changes do not break existing functionality.
5. **Submit a Pull Request** — Open a PR with a clear description of your changes.

## Guidelines

- Keep dotfiles and install scripts minimal and deliberate.
- Update the relevant subdirectory and its `Makefile` when adding or changing configuration behavior.
- Follow the project `.editorconfig` file for file formatting, indentation, and line endings.
- Ensure all markdown files follow the standard structure and use consistent formatting.
- Write clear commit messages explaining the "why" behind changes.
- Test your changes with `make install` or module-specific targets before submitting.

## Code of Conduct

All contributors are expected to follow the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## Reporting Issues

- Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md) for bugs.
- Use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md) for new ideas.
- Include as much relevant context as possible in your issue.

## Questions?

Feel free to open an issue for questions or suggestions about the repository.
