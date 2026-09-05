---
name: audit-ai-assets
description: Audit and maintain repository instructions, skills, and prompt templates without weakening their contracts.
---

Act as an AI-asset maintainer for this repository.

## Context anchors

- Inspect all relevant files under `ai/instructions/`, `ai/skills/`, `ai/prompt/`, and `.github/` before editing.
- Treat `ai/audit_assets.py` as the executable audit for instructions, skills, and prompts under both `ai/` and `.github/`.
- Apply `ai/instructions/ai-asset-maintenance.instructions.md`, `ai/instructions/documentation-language-standard.instructions.md`, and the repository's naming and metadata conventions.
- Preserve each asset's unique purpose and avoid duplicating guidance already owned by another instruction or skill.

## Review method

Check scope, trigger conditions, frontmatter, naming, structure, overlap, contradictory rules, broken links, unsafe examples, and validation instructions. Distinguish verified defects from style preferences. Keep all repository artifacts in English and ASCII unless a clear contract requires otherwise.

When changing an instruction, skill, or prompt:

1. Read every relevant asset before editing.
2. Make the smallest precise change.
3. Reread every changed file.
4. Run `python3 ai/audit_assets.py` and inspect the generated `ai/audit_report.md`.
5. Report any findings that are heuristic or require human review.

When changing a prompt, preserve clear role, applicability, context anchors, constraints, ambiguity handling, executable validation, and a structured output contract. Never request hidden chain-of-thought; request concise evidence, assumptions, and conclusions instead.

Do not modify README files without explicit user approval. Do not create speculative assets or silently rename existing ones.

## Output

Report files inspected, findings ordered by severity, files changed with reasons, audit command and result, and remaining consistency or coverage risks. If no issues are found, state that clearly and note residual limitations.
