---
name: simplify-java-class
description: "Refactors complex Java classes by reducing cyclomatic complexity, simplifying nested control flow, extracting responsibilities, modernizing idioms, and preserving the existing public contract and runtime behavior."
---

# Simplify Java Class

Use this skill when a Java class has high cyclomatic complexity, deeply nested loops or conditionals, duplicated logic, long methods, or violations of the Single Responsibility Principle (SRP). The goal is to reduce complexity while keeping the existing behavior, public API, and business rules intact.

## Objective

- Identify code that is difficult to reason about due to branching, duplication, or excessive responsibility.
- Simplify the class structure without changing its external behavior.
- Improve readability, maintainability, and testability.
- Preserve the public contract, method signatures, and runtime semantics.
- Keep code aligned with modern Java practices where they meaningfully improve clarity.

## Required workflow

1. Analyze the class for complexity signals.
   - High cyclomatic complexity.
   - Deeply nested `if`/`else` blocks.
   - Long methods with multiple responsibilities.
   - Complex loops with repeated checks and early exits.
   - Duplicate validation or transformation logic.
   - SRP violations where one class is doing multiple unrelated jobs.
   - Excessive field bloat or unnecessary coupling.

2. Apply refactoring strategies with minimal behavioral change.
   - Replace complex `if-else` or `switch` chains with polymorphism, pattern matching, or lookup tables where appropriate.
   - Extract long methods into smaller, single-purpose helper methods.
   - Simplify boolean expressions and reduce branching using guard clauses and early returns.
   - Replace imperative code with clearer Java constructs such as Streams API, lambda expressions, `Optional`, or switch expressions when they improve readability without altering behavior.
   - Reduce class coupling by separating validation, transformation, and decision logic into focused methods or internal helpers.
   - Remove duplicated logic by consolidating shared logic into private methods with clear names.

3. Preserve behavior and contracts.
   - Keep public method signatures unchanged.
   - Preserve method return types, parameter types, and all observable behavior.
   - Do not alter business rules, validation requirements, exception semantics, or state transitions.
   - Do not add side effects or hidden behavior changes.
   - If a simplification would change logic, stop and explain the risk instead of making a speculative refactor.

4. Maintain or update documentation.
   - Keep or update Javadoc and comments so they match the simplified implementation.
   - Remove stale comments or comments that no longer reflect the code.
   - Document the intent clearly when a brief comment adds meaningful context.

5. Produce the final response in this strict order.
   1. A brief summary of the complexity issues identified.
   2. The fully refactored Java class in a fenced code block.
   3. A concise bulleted summary of the reductions that were made.

## Refactoring rules

- Prefer guard clauses and early returns over deep nesting.
- Prefer small, well-named helper methods over large monolithic methods.
- Prefer readable linear flow over clever but dense control logic.
- Use polymorphism or lookup tables where they simplify decision logic and reduce branching.
- Use Streams, lambdas, `Optional`, and modern Java patterns only when they clearly improve clarity and preserve semantics.
- Keep state and responsibilities focused; avoid new field bloat or unnecessary abstraction.
- Preserve the existing API contract exactly.
- Do not over-engineer. Only refactor when the simplification improves maintainability and reduces complexity.

## Anti-patterns to avoid

- Do not change public behavior to make the code look cleaner.
- Do not remove or weaken validation logic.
- Do not alter exception behavior or ignore edge cases that the original method handled.
- Do not add abstractions or helper classes unless they meaningfully reduce complexity.
- Do not use modern Java features in a way that obscures the intent or makes the code harder to follow.
- Do not refactor without preserving the class contract and runtime semantics.

## Output format

The final answer must follow this exact structure:

1. Complexity summary
   - Include the main complexity drivers found in the class, such as nested branching, duplicated logic, long methods, or SRP violations.

2. Refactored Java code
   - Provide the complete refactored Java class in a fenced code block.
   - Maintain the original class name, method names, API shape, and overall behavior unless a non-functional internal extraction is required.

3. Complexity reductions summary
   - Add a concise bulleted list of the actual improvements made.
   - Examples: "Reduced cyclomatic complexity by flattening nested conditionals", "Extracted repeated logic into helper methods", "Modernized iteration with Streams", "Preserved public API and business behavior".

## Success criteria

The refactor is successful only if:

- the class is easier to read and maintain,
- nested conditionals and long methods are reduced,
- branching logic is simplified without changing business behavior,
- repeated logic is extracted into clear helper methods,
- modern Java idioms are used where they improve readability,
- and the existing public contract remains intact.

## Example triggers

Use this skill for Java classes such as:

- request validators,
- workflow processors,
- parser or mapper classes,
- domain service logic,
- rule engines,
- or any class with dense conditional logic and repeated business checks.
