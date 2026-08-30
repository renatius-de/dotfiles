---
name: simplify-openapi-spec
description: "Refactor and modernize OpenAPI 3.1 specifications by removing redundancy, extracting reusable components, simplifying polymorphic models, and improving maintainability without changing the contract unless explicitly approved."
---

# Simplify OpenAPI 3.1 Specifications

Use this skill to reduce complexity in an OpenAPI document while preserving the API contract, improving readability, and aligning the specification with modern OpenAPI 3.1 best practices.

## Goal

Refactor a target OpenAPI specification so it is easier to maintain, review, and evolve. The result should be a cleaner, more modular document that prefers reusable components, avoids duplicated inline definitions, and uses concise schema patterns for polymorphism and error handling.

## Required working method

### 1. Analyze the specification before changing it

Inspect the document for:

- repeated inline schemas that should become reusable `components/schemas`
- duplicated query, header, or path parameters that should move to `components/parameters`
- repeated error payloads and status responses that should be centralized in `components/responses`
- overly nested object structures that can be simplified without changing meaning
- redundant path-level or operation-level declarations
- non-standard or inconsistent endpoint naming, response patterns, or status codes
- complex `allOf`/`oneOf`/`anyOf` chains that can be flattened into clearer compositions
- large request/response bodies defined inline instead of through shared components

When identifying improvement opportunities, keep behavior and compatibility in mind. Do not change semantics unless the user explicitly approves a breaking change or a contract-altering update.

### 2. Ask clarifying questions before making assumptions

Before modifying the spec, ask concise clarifying questions if any of the following is unclear:

- whether all previous API behaviors must remain unchanged
- whether minor adjustments to existing behaviors are acceptable
- whether the change can alter existing API behaviors significantly, requiring client updates
- required authentication or authorization model
- missing or ambiguous data types
- unknown client impact or migration constraints
- required naming convention for schemas and fields
- whether a field is nullable, optional, or required in the source system

Use short, specific questions focused only on missing facts. If the project context is unclear or the domain contract is ambiguous, stop and ask instead of guessing.

### 3. Apply modern OpenAPI 3.1 patterns

Refactor the specification using these rules:

- Prefer reusable `components/schemas` for all repeated or non-trivial payloads.
- Move repeated parameters into `components/parameters`.
- Centralize recurring error shapes in `components/responses` and reference them consistently.
- Keep path and operation declarations concise; avoid unnecessary duplication.
- Prefer composition over deep, repeated inline declarations.
- Use `oneOf` or `anyOf` only when they accurately model polymorphism or union semantics.
- Keep polymorphic definitions readable and constrained; avoid excessive nesting.
- Use clear schema names such as `CreateUserRequest`, `UserResponse`, `ErrorResponse`, `PaginationMeta`, or `ApiError`.
- Preserve compatibility with OpenAPI 3.1 features such as `nullable`, `type: object`, and JSON Schema-compatible constraints.
- Keep examples realistic and aligned with the schema.
- Prefer consistent casing conventions across the entire document, for example camelCase for property names and kebab-case for path segments.
- Avoid custom vendor extensions unless required by the existing contract.

### 4. Simplify structure without hiding meaning

When refactoring, prefer these transformations:

- Inline object schemas -> reusable components
- Repeated `parameters` -> `components/parameters`
- Repeated `responses` -> `components/responses`
- Repeated enum/value definitions -> shared schema components
- Deeply nested inline models -> flatter models with clear names
- Unclear polymorphism -> small, well-scoped `oneOf` or `anyOf` branches
- Duplicated descriptions -> centralized component-level documentation

Do not flatten essential domain distinctions into a generic schema unless the actual API contract truly supports that simplification.

### 5. Maintain correctness and contract integrity

Before finalizing the refactor:

- verify that all `$ref` targets resolve correctly
- confirm that required fields remain required
- preserve authentication and authorization semantics
- keep status codes valid and meaningful
- avoid changing operation purpose, resource hierarchy, or request semantics unless approved
- ensure all examples remain valid with the final schema
- preserve or improve operation descriptions and summaries

## Decision rules

When the refactor is obvious and the contract is clear:

- proceed directly with the simplification
- keep the change focused and minimal
- produce a cleaner equivalent API design

When the contract is ambiguous or the user has not confirmed requirements:

- stop and ask a targeted clarifying question
- do not guess missing business rules, auth behavior, or client-breaking changes

## Expected output

Provide:

1. the modernized OpenAPI document in valid YAML or JSON
2. a concise summary of the structural improvements made
3. a list of any assumptions or approval requirements that remain

The output should emphasize:

- modularity
- maintainability
- clear schema ownership
- reduced duplication
- reduced inline complexity
- compatibility with OpenAPI 3.1

## Quality bar

The refactored specification should be:

- easier to navigate
- easier to review in pull requests
- easier to extend without copy-paste duplication
- explicit about contracts and error handling
- safe for tooling and code generation

## Example refactoring patterns

Use patterns such as:

- `#/components/schemas/User` instead of repeated inline user payloads
- `#/components/parameters/PageParam` instead of repeated page query parameter blocks
- `#/components/responses/NotFound` instead of repeated 404 payload definitions
- `oneOf` for strict polymorphic payloads with a small number of meaningful variants
- `allOf` only when composition is genuinely needed and remains readable

## Final instruction

Refactor the supplied OpenAPI document using the smallest correct, modern OpenAPI 3.1 approach that reduces complexity while preserving the contract unless the user explicitly approves a breaking change. Provide the updated spec and a short summary of the main simplifications.
