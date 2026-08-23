# Contributing

Contributions are welcome. Please keep changes focused, well-tested, and consistent with the repository’s existing structure.

## Contribution Workflow

1. Fork the repository.
2. Create a descriptive branch, for example `feature/zsh-cleanup` or `fix/ssh-config`.
3. Keep edits limited to the relevant module or documentation section.
4. Validate the change locally with a dry run or module-specific `make` target.
5. Open a pull request with a clear summary of the change and its motivation.

## Project Guidelines

- Keep dotfiles and installation scripts minimal and intentional.
- Update the relevant module directory and its `Makefile` when changing behavior.
- Prefer repository-managed configuration files over directly editing installed home-directory copies.
- Maintain formatting consistency with the repository’s `.editorconfig` rules.
- Keep markdown documentation clear, concise, and aligned with current repository behavior.
- Write commit messages that explain the purpose of the change, not just the file names.

## Validation

Before submitting:

```bash
make -n install
```

You may also run a module-specific dry run if you changed a single component:

```bash
make -n -C zsh install
make -n -C vim install
make -n -C git install
```

## Code of Conduct

All contributors are expected to follow the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## Reporting Issues

- Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md) for bugs.
- Use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md) for enhancements or new ideas.
- Include the relevant module, command, environment details, and reproduction steps.

## Questions

Open an issue if you have a question, suggestion, or proposal for improving the repository.
