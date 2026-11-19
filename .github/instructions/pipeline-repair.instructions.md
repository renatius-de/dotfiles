---
name: pipeline-repair
description: "Use when diagnosing, repairing, or optimizing GitHub Actions workflows and CI pipeline failures."
applyTo: "**/.github/workflows/**"
---

# GitHub Actions Pipeline Repair

## Scope

For `.github/workflows/`: diagnose failed jobs and fix root causes while preserving workflow intent, permissions, triggers, and useful checks. Make the smallest reliability/maintenance change.

## Required workflow

### 1. Inspect before editing

- Read affected workflows, reusable workflows, referenced local actions, and the complete failing log; identify the first actionable error, not a later symptom.
- Check repository instructions, action/runtime versions, runners/containers, commands, environment, caches, artifacts, and required tools.
- Classify the failure as workflow syntax, action compatibility, runner or container setup, dependency installation, permissions, credentials, network or certificate trust, shell behavior, test failure, or repository code failure.

### 2. Repair the root cause

- Preserve triggers, job names, required checks, dependency order, least-privilege permissions, and failure semantics unless the root cause requires change.
- Pin actions to the repository's established major versions and use a supported runtime for JavaScript actions.
- Install job-container tools before first use; include CA certificates when using Git, package managers, or HTTPS APIs.
- Ensure the configured shell exists and is executable. Install `zsh` when Zsh scripts are validated; retain POSIX `sh` for container and action compatibility.
- Prefer minimal images only when their package manager, libc, certificate store, shell, Git behavior, and action compatibility are understood. Do not switch to Alpine merely to reduce image size when it creates avoidable compatibility risk.
- Keep package installation non-interactive, clean indexes in the same layer/step, and avoid unrelated tools.
- Use explicit working directories, quoting, and fail-fast shell behavior where needed. Do not hide errors with `|| true`, disabled checks, or unconditional success commands.
- Keep secrets in GitHub Secrets or variables. Never print, hard-code, or persist secret values.

### 3. Security and change boundaries

- Never disable TLS/certificate verification, use insecure repositories, weaken permissions, or add privileged containers to pass a pipeline.
- Never remove tests, security scans, dependency review, CodeQL, SARIF upload, or validation steps merely to avoid a failure.
- Never invent credentials, tokens, service endpoints, image tags, resource limits, or generated output.
- Do not force-push, commit, rewrite history, or change unrelated files unless explicitly requested.
- Treat changes to permissions, external services, publishing, deployment, persistence, or release behavior as high risk and explain them before applying them.

## Validation

- Parse every changed workflow as YAML.
- Run `actionlint` when available and resolve all relevant diagnostics.
- Run relevant local validation/tests for the changed slice, including Makefile dry runs, Python checks, and shell syntax checks when used by the workflow.
- Inspect `git diff --check` and the final diff for accidental permission, trigger, secret, path, or dependency changes.
- When Docker is available and the change affects a job container, verify the image can install the required tools and certificates. Do not claim a hosted GitHub Actions run was verified locally.
- If a required external check cannot be run, report the exact limitation and the remaining risk.

## Completion criteria

A pipeline repair is complete only when the root cause is addressed, existing intended checks remain enabled, security controls are preserved, changed workflows validate successfully, and any unavailable hosted-run verification is stated explicitly.
