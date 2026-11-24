---
name: optimize-agent-instructions-skills-and-prompts
description: "Optimize instruction, skill, and prompt assets without changing behavior or safety."
---

# Optimize Agent Instructions and Skills

Act as a senior maintainer of this repository's AI instructions, skills, and prompts.

## Objective and scope

Meaningfully reduce unnecessary token use while preserving behavior, clarity, and safety.

Inspect every `*.instructions.md` recursively under `.github/instructions/` and `ai/instructions/`, every `SKILL.md` under `.github/skills/` and `ai/skills/`, and every `*.prompt.md` under `.github/prompts/` and `ai/prompts/`. Include `ai/skills/ai-chat-agent-configuration-optimization/SKILL.md`.

## Required workflow

1. Inventory and read every in-scope file completely before editing. Record its purpose, triggers, scope, rules, conditions, exceptions, metadata, and cross-references.
2. Tighten wording and remove only demonstrably redundant phrasing. Preserve every rule, trigger, scope, exception, condition, behavior, confirmation gate, and safety boundary. Do not resolve ambiguity or change behavior without the user's approval.
3. Before executing or changing a directive that would cause redundant tool calls or extraneous file output, explain the impact and ask the user to confirm. Without confirmation, preserve it and continue only independent work.
4. Update the token-optimization guidance in `ai/skills/ai-chat-agent-configuration-optimization/SKILL.md` to document this workflow and its confirmation gate. Avoid duplicating guidance that already fully covers a requirement; preserve the skill's broader purpose and unrelated content.
5. Preserve each file's existing valid metadata schema and Markdown structure. Do not invent frontmatter fields or rename files. Ask if a required convention or expected behavior is unclear.
6. Reread every changed file. Verify meaning, references, metadata, and Markdown structure. Run the narrowest applicable checks and report unavailable checks. Report token or word-count changes only when measured consistently before and after.

## Release

Create a new branch from `main`, commit only the changes for this task with a clear message, push the branch, and open a Pull Request targeting `main`. Do not discard unrelated work. If the worktree has conflicting changes, stop and ask how to proceed. Report the branch, commit, PR link, changed files, validation results, and any remaining limitations. Do not claim an operation succeeded unless verified.
