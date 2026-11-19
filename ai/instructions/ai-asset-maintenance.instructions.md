---
name: ai-asset-maintenance
description: "Use when updating repository AI instructions and skills; enforce naming consistency, metadata quality, structural clarity, and final verification across all .instructions.md and SKILL.md files."
applyTo: "**/*.instructions.md,**/SKILL.md"
---

## Scope

Applies whenever repository `**/*.instructions.md` or `**/SKILL.md` files or names are reviewed, refactored, or synchronized. Maintain consistent, discoverable assets. Covers AI-asset hygiene, not Java quality, API specifications, or documentation approval.

## Required behavior

### 1. Inventory and analyze

Before editing, read every relevant file in scope and identify:

- completeness, coverage, clarity, maintainability, redundancy, overlap, naming, metadata, and structural consistency

Do not assume a file is correct just because it exists. Check actual content, purpose, and consistency.

### 2. Improve content quality

Adjust content only to improve correctness or maintainability: remove duplication, clarify tasks and triggers, remove vague or speculative claims, keep scope/workflow/validation explicit, and preserve each asset's unique intent. Use concise, direct English; prefer focused files over bloated or duplicated ones.

### 3. Standardize naming

Apply one consistent naming scheme across all AI asset files.

Use `domain-focus.instructions.md` for instructions and `domain-focus/SKILL.md` for skills.

Examples:

- `execution-direct-mode.instructions.md`
- `code-quality-complexity.instructions.md`
- `java-25-ecosystem-standards.instructions.md`
- `openapi-spec-authoring.instructions.md`
- `java-record-conversion/SKILL.md`
- `makefile-optimization/SKILL.md`
- `openapi-spec-refactoring/SKILL.md`

Use kebab-case, consistent verbs, and domain-first naming. Avoid legacy title casing or inconsistent identifiers.

### 4. Normalize metadata

For every instruction or skill file:

- Start YAML frontmatter with `---`; include `name`; keep `description` concise/action-oriented and `applyTo` meaningful where relevant; align metadata with filename and purpose.

Do not leave orphaned or mismatched names, descriptions, or scopes.

### 5. Keep structure predictable

Use a clear title, scope, required behavior/workflow, prohibitions, validation, and concise success criteria or output expectations. Keep each file focused on one domain or recurring task.

### 6. Preserve purpose and avoid overreach

Do not broaden a file beyond its use: instructions define operating rules and guardrails; skills define focused workflows and decision rules. Keep unrelated responsibilities separate and do not rewrite correct wording for style alone.

### 7. Verify the result

After edits/renames, reread changed files; check frontmatter, naming, structure, references, metadata, and semantic validity. Use the smallest direct check that proves validity.

## Do not

Avoid legacy names when a clearer standard exists, strongly overlapping assets, speculative content, missing `name` or malformed frontmatter, unrelated changes, and workflow steps unsupported by repository usage.

## Quality standard

Favor clear, consistent, maintainable assets; write generated text in English unless asked otherwise. Prefer precise improvements and treat naming, metadata, and verification as required.

## Completion checklist

Confirm all relevant files were reviewed; naming/metadata are consistent; content is concise, purposeful, and free of reducible redundancy; and every changed file was reread and validated.

## Success criteria

The asset set is consistent, discoverable, maintainable, free of duplicate or weak guidance, and structurally verified.
