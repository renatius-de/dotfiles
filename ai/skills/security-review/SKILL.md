---
name: security-review
description: "Review authorized code and configuration changes for evidence-based security risks."
---

# Review Code and Configuration for Security Risks

Use this skill for a requested security review of source code, configuration, or a proposed change. Keep the review within the user-authorized scope.

## Required workflow

### 1. Establish scope

- Identify the requested files, change set, and relevant security boundary from the supplied context.
- Review only materials needed to trace the suspected behavior. Do not access unrelated systems, credentials, or personal data.
- If authorization, target, or review boundaries are unclear, ask before proceeding.

### 2. Trace behavior and assess evidence

- Follow inputs, trust boundaries, authorization checks, sensitive data, and relevant control flow through the code or configuration.
- Consider realistic preconditions, attacker capabilities, impact, and existing mitigations. Distinguish confirmed behavior from assumptions and unverified hypotheses.
- Prefer precise, actionable findings tied to specific evidence. Do not report style concerns or speculative risks as vulnerabilities.
- Use available static evidence and safe local checks. Do not exploit live systems, execute harmful payloads, access unauthorized targets, or produce weaponized proof-of-concept instructions.
- Do not expose secrets, private data, or sensitive exploit details in the report.

### 3. Report findings

For each finding, include:

- Severity and concise title.
- File and line or configuration location.
- The vulnerable condition and the evidence supporting it.
- Preconditions and likely impact, stated without overstating certainty.
- A focused remediation direction and any safe validation that would confirm the fix.

Order findings by severity. If no actionable issue is supported by the reviewed evidence, say so and state the scope and limitations; do not imply that the system is free of vulnerabilities.

## Decision rules

- Do not modify files as part of a review unless implementation is separately requested.
- Do not infer exploitability from a dependency name, scanner alert, or code pattern alone; trace the affected behavior and version/context where available.
- Do not run active tests against a remote target without explicit authorization and a safe, bounded plan.
- Ask for clarification when the security boundary, expected trust model, or intended behavior materially affects the assessment.

## Expected output

Provide a concise scope statement, prioritized evidence-based findings, safe remediation guidance, validation performed, and material limitations. Separate confirmed findings from unknowns.

## Success criteria

The review is bounded to authorized materials, every finding is evidence-backed and actionable, sensitive information remains protected, and validation claims accurately reflect what was checked.
