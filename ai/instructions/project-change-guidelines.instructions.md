---
name: project-change-guidelines
description: "Use when changing a software project; guide repository research, focused implementation, and relevant validation."
applyTo: "**/*"
---

# Project Change Guidelines

## Scope

- Applies when modifying code, configuration, tests, or documentation in any project.
- Follow project-specific instructions and base decisions on the repository's actual structure and behavior.

## Required behavior

- Inspect relevant source, configuration, tests, and project guidance before editing.
- Make the smallest complete change that addresses the request; follow established conventions and keep unrelated areas untouched.
- Preserve existing behavior and user data unless the requested change requires otherwise.
- Reuse existing project tools and dependencies; avoid adding dependencies or abstractions without a clear need.
- Update related tests and documentation when they are necessary to keep the change correct and understandable.

## Verification

- Run the existing, relevant tests, linters, or builds for the changed areas.
- Review the final diff and verify that the change is scoped, behavior is correct, and no unrelated files or data are affected.
- Consider security implications introduced by the change and address issues directly related to it.

## Success criteria

- The requested behavior is implemented consistently with the project.
- Relevant validation passes, and the final change contains no unrelated modifications.
