---
name: testing-quality
description: "Design and run focused, reliable tests that verify observable behavior."
applyTo: "**"
---

# Testing Quality Standards

## Scope

Apply when adding, changing, or reviewing automated tests and their validation workflow. Preserve the project's established test framework, conventions, and supported runtime.

## Required behavior

- Test observable behavior and public contracts rather than implementation details.
- Keep each test focused on a meaningful scenario. Cover relevant success paths, boundaries, invalid input, and failure behavior without duplicating existing coverage.
- Make tests deterministic and isolated. Avoid dependence on test order, shared mutable state, real external services, wall-clock timing, or network availability unless the test specifically validates that integration.
- Use the project's existing fixtures and test utilities. Mock only external or nondeterministic boundaries; prefer real values and behavior for simple domain logic.
- Clean up resources created by tests, including temporary files, processes, containers, and external records.
- Preserve test assertions that express real requirements. Do not weaken a failing test, alter expected results, or skip coverage merely to make a run pass; establish the behavior from the contract first.
- Run the narrowest relevant test or validation command, then expand coverage when the change affects shared behavior. Report the exact commands and distinguish executed checks from checks not run.
- Ask for clarification when expected behavior, test boundaries, or failure semantics are materially unclear.

## Do not

- Do not add a test framework or dependency without a clear requirement and compatibility check.
- Do not use arbitrary sleeps, broad exception handling, hidden global state, or test-order dependencies to mask nondeterminism.
- Do not claim tests passed when they were not run successfully.
- Do not add tests that merely restate implementation details or assert language/framework behavior.

## Quality standard

Tests should be readable, repeatable, isolated, and proportionate to the behavior changed. Keep test setup simpler than the behavior it verifies where practical.
