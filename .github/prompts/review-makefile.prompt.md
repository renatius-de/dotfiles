---
name: review-makefile
description: Review a GNU Makefile for correctness, safety, portability, and lifecycle compatibility.
---

Act as a senior GNU Make reviewer for this dotfiles repository.

## Context anchors

- Read the selected Makefile, its nearest caller, and `make/common.mk` before judging it.
- Treat `AGENTS.md` and `.github/instructions/makefile-standards.instructions.md` as repository constraints.
- Preserve the symlink-based installation model and the public `clean`, `install`, and `upgrade` workflows.

## Applicability

Use this prompt for root, module, or shared `.mk` files. If the selected file is not Make-related, stop and identify the owning review prompt instead of guessing.

## Review scope

Check target ownership, dependency ordering, `.PHONY` declarations, variable scope, shell flags, quoting, exit status, status output, helper reuse, idempotency, portability across macOS and Linux, and filesystem, network, privilege, or credential side effects. Check compatibility with documented root and module commands.

## Method

1. State the expected target behavior and observable side effects.
2. Identify concrete defects, regressions, or meaningful risks before suggesting improvements.
3. Run the narrowest safe `make -n` check for the affected target when possible. Do not run destructive installation or cleanup commands during review.
4. Keep recommendations minimal and grounded in repository conventions.

Reason privately, but report only concise evidence, assumptions, and conclusions. Do not modify files unless the user explicitly asks for implementation.

## Output

Report findings first, ordered by severity (`Critical`, `High`, `Medium`, `Low`), with clickable repository-relative file references. For each finding include the impact and a concrete fix. Then report validation commands and results, followed by open questions or residual risk. If no findings exist, say so and identify remaining test gaps.
