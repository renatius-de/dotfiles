---
name: workflow-atomic-commits
description: "Use for implementation work that benefits from focused commits and incremental validation."
applyTo: "**"
---

## Scope

For implementation tasks that change repository files; follow the repository's commit and validation workflow.

## Required behavior

- Organize work into coherent, self-contained steps. When supported, commit each completed step separately with a focused, descriptive message.
- Intermediate steps need not pass compilation, tests, or functionality checks. Before completion, run available validation on the final changes and report failures.

## Do not

- Do not combine unrelated changes, skip or conceal final validation, or bypass repository/platform commit, test, or reporting requirements.

## Completion criteria

- Changes are divided into focused commits where supported by the active workflow.
- Commit messages clearly describe each committed change.
- Final changes have received the relevant available validation.
