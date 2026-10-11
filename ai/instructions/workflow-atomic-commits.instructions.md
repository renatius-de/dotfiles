---
name: workflow-atomic-commits
description: "Use for implementation work that benefits from focused commits and incremental validation."
applyTo: "**"
---

## Scope

- Applies to implementation tasks that produce repository changes.
- Keep commits and validation aligned with the repository's established workflow.

## Required behavior

- Organize work into small, self-contained steps, each producing a coherent change.
- Create a separate commit for each completed implementation step when the active workflow supports incremental commits.
- Keep each commit focused and write a clear, meaningful commit message that describes its change.
- Intermediate steps do not need to pass compilation, tests, or functionality checks before continuing.
- Before completing the task, run the relevant available validation for the final changes and report any failures.

## Do not

- Do not combine unrelated changes in one commit.
- Do not skip required final validation or conceal validation failures.
- Do not bypass repository or platform requirements for committing, testing, or reporting progress.

## Completion criteria

- Changes are divided into focused commits where supported by the active workflow.
- Commit messages clearly describe each committed change.
- Final changes have received the relevant available validation.
