---
name: execution-summary
description: "Require a concise English summary of all file changes at the end of every completed task."
applyTo: "**/*"
---

# Execution Summary Instruction

## Scope

- Apply this rule to every completed task or execution, regardless of the files or systems involved.
- This rule governs the final response summary and does not replace task-specific reporting requirements.

## Required behavior

- End every completed task response with a clearly labeled `Summary` section.
- Write the entire summary strictly in English, even when the rest of the response uses another language.
- Briefly describe every file added, modified, or deleted and the change made to it.
- Keep the summary concise, clear, and focused on material changes such as features, removed code, or structural updates.
- If no files changed, state that explicitly.

## Required format

```markdown
## Summary
- `path/to/file` — concise description of the change
```

When no files changed, use `## Summary` followed by `No files changed.`

## Do not

- Do not omit the summary after completing a task or execution.
- Do not include unsupported claims, unrelated details, or lengthy implementation narratives in the summary.
- Do not write any part of the summary in a language other than English.

## Completion criteria

- The final response ends with a concise, accurate English summary of every file change, or explicitly states that no files changed.
