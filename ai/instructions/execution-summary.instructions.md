---
name: execution-summary
description: "Require a concise English summary of all file changes at the end of every completed task."
applyTo: "**/*"
---

# Execution Summary Instruction

## Scope

Applies to every completed task, in addition to its task-specific reporting requirements.

## Required behavior

- End every completed response with a clearly labeled `Summary` in English, regardless of the response language.
- Concisely describe each added, modified, or deleted file and its material change. If none changed, say so.

## Required format

```markdown
## Summary
- `path/to/file` — concise description of the change
```

When no files changed, use `## Summary` followed by `No files changed.`

## Do not

- Do not omit the summary, add unsupported/unrelated claims or lengthy narratives, or use a language other than English in it.

## Completion criteria

The response must end with an accurate, concise English summary of every changed file, or explicitly state that no files changed.
