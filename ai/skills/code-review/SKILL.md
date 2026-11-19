---
name: code-review
description: "Review a requested change for concrete correctness, compatibility, and maintainability defects."
---

# Review Code Changes

Use this skill when asked to review a diff, pull request, or specified code change. Review the change for defects; do not implement fixes unless requested separately.

## Required workflow

### 1. Establish review scope

- Identify the exact diff or files under review and the intended behavior from the request and supplied project context.
- Read only the surrounding code and tests needed to understand changed behavior and affected callers.
- Preserve unrelated work and do not assume undocumented requirements.

### 2. Analyze the change

- Prioritize correctness, security, data integrity, compatibility, failure behavior, and regressions introduced by the change.
- Trace affected call paths and boundary conditions where they materially affect the result.
- Use existing tests and safe static checks as evidence when available. Do not claim a check passed if it was not run successfully.
- Report only actionable issues introduced or exposed by the change. Avoid style preferences, speculative concerns, and findings outside the requested scope.
- For security-sensitive concerns, use the dedicated security-review workflow when requested or when a security assessment is the task.

### 3. Report findings

For each finding, provide:

- Severity and a concise title.
- The exact file and line location in the changed code.
- The triggering condition and concrete impact.
- A focused correction direction.

Order findings by severity. If no actionable issues are found, say so explicitly and note important review limitations. Keep general observations separate from findings.

## Do not

- Do not modify the change or create commits as part of a review unless explicitly asked.
- Do not report issues based only on naming, style, or hypothetical future use.
- Do not treat passing tests as proof that all behavior is correct or secure.
- Do not reproduce secrets or sensitive data from the reviewed content.

## Expected output

Lead with actionable findings, if any, followed by concise validation notes and material limitations. Findings must be specific enough to verify and fix.

## Success criteria

The review is focused, evidence-based, prioritized, and limited to defects relevant to the requested change.
