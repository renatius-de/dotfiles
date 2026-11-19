---
name: github-actions-workflow
description: "Maintain GitHub Actions workflows with minimal, validated, and least-privilege changes."
applyTo: "**/.github/workflows/**"
---

# GitHub Actions Workflow Standards

## Scope

Apply when authoring, reviewing, or changing GitHub Actions workflow files. Preserve the workflow's intended events, outputs, permissions, and deployment behavior.

## Required behavior

- Read the complete affected workflow and the directly related workflow or reusable-workflow files needed to understand its triggers, inputs, outputs, permissions, and side effects.
- Preserve event filters, job dependencies, conditions, concurrency behavior, and artifact contracts unless the requested change requires otherwise.
- Grant each workflow and job only the `GITHUB_TOKEN` permissions it needs. Keep privileged jobs separate from untrusted pull-request code.
- Treat workflow inputs, pull-request content, artifacts, and outputs as untrusted data. Do not interpolate untrusted values into shell commands or privileged contexts without safe validation and handling.
- Pin third-party actions to verified full commit SHAs where practical. Verify action ownership, version, inputs, and outputs using authoritative project sources before changing references; do not guess versions or SHAs.
- Keep credentials in the platform's secret mechanism. Never print secrets, expose them to untrusted code, or add secret values to workflow files.
- Review changes to release, deployment, publishing, permissions, and external service access for side effects. Do not dispatch workflows, publish artifacts, deploy, or modify external resources without explicit approval.
- Preserve existing runner and toolchain requirements. Use project-provided validation first; do not install tools or change unrelated workflows to satisfy a check.

## Validation

- Validate workflow syntax and expressions with tools already available in the project when practical.
- Inspect the final diff for unintended trigger changes, excessive permissions, secret exposure, unsafe shell interpolation, unpinned action references, and unapproved release or deployment behavior.
- Report the exact checks run and any validation blocked by unavailable tools or platform access. Static validation does not prove that a workflow succeeds on GitHub-hosted runners.

## Do not

- Do not broaden triggers, token permissions, runner access, or secret availability without a demonstrated requirement.
- Do not run or dispatch workflows that publish, deploy, or otherwise affect external systems without explicit approval.
- Do not use unverified action references, expose secrets in logs, or claim runtime success based only on source inspection.
- Do not alter unrelated workflow behavior as incidental cleanup.

## Success criteria

The change preserves the intended workflow contract, uses least privilege, protects secrets and untrusted inputs, and has accurate validation results and remaining risks reported.
