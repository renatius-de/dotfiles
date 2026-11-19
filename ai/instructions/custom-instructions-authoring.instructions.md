---
name: custom-instructions-authoring
description: 'Guidelines for creating high-quality custom instruction files for GitHub Copilot'
applyTo: '**/*.instructions.md'
---

# Custom Instruction File Guidelines

## Purpose and placement

Create focused, maintainable guidance for developers and GitHub Copilot. Use Markdown with YAML frontmatter. Name files in lowercase kebab-case and place them in `.github/instructions/`, unless the workspace defines another supported location.

## Frontmatter

VS Code treats `name`, `description`, and `applyTo` as optional fields. This repository's AI asset convention requires all three and aligns `name` with the filename. Keep the required `description` and `applyTo` values as follows:

- Write a single-quoted `description` of 1–500 characters that states the instruction's purpose and scope.
- Set `applyTo` to one or more comma-separated glob patterns. Patterns are relative to the workspace root, not the instruction file's directory. Use `**` to match all files.
- Keep the YAML between `---` delimiters.

```yaml
---
name: python-tests
description: 'Guidance for Python tests'
applyTo: 'tests/**/*.py'
---
```

## Structure and scope

- Start with a clear title and brief overview. Add project context only when it helps the reader apply the rules.
- Include only sections relevant to the instruction's scope. Common sections include general guidance, coding standards, architecture, common patterns, security, performance, testing, and validation.
- Cover recurring concerns such as naming, organization, error handling, dependencies, documentation, or supported versions only when they matter to the target files.
- Keep instructions focused on actionable guidance; do not duplicate rules already enforced by formatters, linters, or other project instructions.

## Writing guidance

- Use clear, concise, direct language and actionable verbs.
- Explain why a rule exists when the reason helps resolve a non-obvious decision.
- Prefer a short rule set that defines the expected outcome. Add constraints in response to demonstrated needs rather than hypothetical cases.
- Use bullets for independent rules and tables for comparisons or compact reference data when they improve readability.
- Link to authoritative documentation when useful; keep links relevant and current.

## Examples and code snippets

Use an example when it clarifies a non-obvious rule, decision, or expected output. Keep examples representative and minimal; label alternatives when comparison is useful. Ensure code examples are correct and runnable when presented as runnable. Do not add code blocks, tables, or templates merely to make an instruction look complete.

## Validation and maintenance

Before finalizing an instruction file:

1. Check that the frontmatter is valid and follows the repository convention.
2. Confirm that `applyTo` matches the intended workspace files.
3. Check that links resolve and any included examples are accurate; run executable examples when practical.
4. Test the guidance in a new VS Code chat with a representative task, without repeating the rules in the prompt. Confirm discovery separately from whether the agent followed the guidance.

Review instructions when the relevant code, tools, dependencies, or project conventions change. Keep them accurate and remove obsolete guidance.

## Minimal example structure

Adapt this structure to the task; omit sections that do not add useful guidance.

```markdown
---
name: topic-guidance
description: 'Brief purpose and scope'
applyTo: 'src/**/*.py'
---

# Topic

## Scope

State when this guidance applies.

## Required behavior

- Describe the project-specific behavior.

## Validation

- Give the relevant command or check.
```

## Avoid

- Overly broad, verbose, ambiguous, or contradictory rules.
- Stale practices, unsupported claims, and unverified examples.
- Copying external documentation without adding project-specific value.
- Requiring an example when a precise rule is already clear.
- Inventing hypothetical edge cases or repeating the same guidance in multiple sections.
