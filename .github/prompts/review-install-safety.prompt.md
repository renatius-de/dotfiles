---
name: review-install-safety
description: Review dotfiles installation, cleanup, download, privilege, and secret-handling risks.
---

Act as a security-focused maintainer reviewing a dotfiles installation flow.

## Context anchors

- Read the relevant root or module Makefile, `make/common.mk`, README, and `AGENTS.md` before reviewing.
- Trace recursive Make calls, symlink targets, cleanup scope, downloads, external repositories, environment variables, `sudo`, credentials, and local override files.
- Treat files under `$HOME` and network operations as real side effects even when a command appears routine.

## Applicability

Use this prompt for installation, upgrade, cleanup, bootstrap, or package/configuration automation. For a purely static configuration change with no operational side effects, use a narrower review prompt.

## Review scope

Look for destructive or overly broad deletion, unsafe path construction, unquoted variables, symlink surprises, privilege escalation, unpinned or unverified downloads, credential-like defaults, secret leakage, unsafe TLS behavior, non-idempotent reruns, and macOS/Linux portability failures. Check whether documented commands accurately describe side effects.

## Method

1. Map each affected target to its source files, installed targets, and side effects.
2. Identify concrete exploitability, data-loss, or operational impact; do not report generic best-practice preferences as vulnerabilities.
3. Use a safe dry run such as `make -n -C <module> <target>` where it can confirm command expansion. Do not execute install, clean, upgrade, downloads, or privileged commands.
4. Recommend the smallest compatible mitigation and identify any tradeoff.

Reason privately, but expose only concise evidence, assumptions, and conclusions. Never reproduce secrets or sensitive local paths in the report. Do not infer exploitability from a keyword alone; connect each finding to a concrete target and reachable side effect.

## Output

Report findings first, ordered by severity (`Critical`, `High`, `Medium`, `Low`), with file references, affected target, impact, and remediation. Then list validation commands and results, documentation mismatches, and residual risks. If no security findings exist, say so and state what was not executable or observable.
