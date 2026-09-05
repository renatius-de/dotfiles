---
name: openapi-optimize-and-diff
description: "Refactor and modernize OpenAPI 3.1 specifications by removing redundancy, extracting reusable components, simplifying polymorphic models, and improving maintainability, then validate changes with OASDiff without changing the contract unless explicitly approved."
---

# Simplify OpenAPI 3.1 Specifications and Compare Changes

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

### 3.1 Apply Spring Boot 4 extension conventions carefully

Spring Boot 4 and OpenAPI 3.1 do not define a universal set of `x-` extensions. Treat every vendor extension as metadata for a named consumer such as springdoc-openapi, a code generator, or an internal platform. Before adding or retaining an extension:

- identify the tool and version that consumes it
- preserve the consumer's expected value type and location
- keep the standard OpenAPI field authoritative when an equivalent exists
- do not invent an extension merely to replace `tags`, `content`, `security`, `responses`, or JSON Schema validation keywords
- keep unknown extensions when they are part of the existing contract, but do not propagate them to unrelated operations

Use the following extensions only when the consuming Spring Boot 4 integration explicitly supports them. Unless a consumer contract says otherwise, place operation-specific extensions on the operation object, resource-wide metadata on the path item or root document, and enum metadata on the schema that declares the enum.

| Extension | Placement and value | Apply when |
| --- | --- | --- |
| `x-tags` | Root document, path item, or operation as an array of tag strings; keep the standard `tags` field synchronized when both are present. | A downstream grouping or code-generation tool requires additional tag metadata. Do not use it as a substitute for standard `tags`. |
| `x-content-type` | Operation, request body, or response as the consumer-defined media-type string or list; keep the standard `content` map authoritative. | A Spring integration needs an explicit generated content type that cannot be inferred reliably. Validate the value against the media types in `content`. |
| `x-spring-paginated` | Operation as a boolean, normally on collection `GET` operations. | The Spring integration must generate or recognize pagination parameters and pagination metadata. Do not add it to item, command, or non-paginated operations. |
| `x-version-param` | Operation as the exact API-version parameter name or the consumer-defined parameter descriptor; the corresponding parameter must also be declared in `parameters`. | Versioning is selected through a request parameter. Keep the parameter location, type, requiredness, and allowed values consistent with the standard parameter declaration. |
| `x-spring-api-version` | Root document, path item, or operation as the consumer-defined API version value; prefer the narrowest scope that is correct. | A Spring API-versioning integration needs an explicit version mapping. Do not use it to silently change an existing version contract. |
| `x-enum-description` | Enum schema as a map keyed by the exact enum value, or the exact consumer-defined description format. | Generated clients or documentation need descriptions for individual enum values. Every key must exist in the schema's `enum` array. |

For pagination, versioning, and content negotiation, also model the real HTTP contract with standard OpenAPI fields: declare query or header parameters, media types under `content`, response links or pagination schemas where applicable, and explicit status codes. Vendor metadata must never be the only representation of behavior visible to clients.

For Spring security, auditing, errors, and validation, prefer standard OpenAPI and JSON Schema constructs before adding more vendor extensions:

- use `components/securitySchemes`, operation-level `security`, and explicit scopes or roles for authentication and authorization
- use reusable `components/responses` and error schemas for problem details, stable error codes, and documented status codes
- use `required`, `propertyNames`, `pattern`, `format`, `minLength`, `maximum`, `unevaluatedProperties`, and related JSON Schema keywords for validation
- represent audit fields and audit endpoints with explicit schemas, descriptions, read-only properties, and documented operations

Only add a project-specific extension such as `x-audit-event`, `x-error-code`, or `x-validation` when its schema, owner, supported locations, and consuming tool are documented by the project. Never present such extensions as Spring Boot 4 standards.

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
- verify every retained `x-` extension against its consumer contract, including location and value type
- ensure extension metadata does not contradict standard OpenAPI fields or change generated client behavior unexpectedly

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

## Mandatory OASDiff validation

After every change to an OpenAPI specification, such as `openapi.yaml`, start OASDiff via Docker. Compare the changed local file with the same path from the repository's `main` or `master` branch. Use `main` when both branches exist; otherwise use `master`. Resolve the specification path from the branch being compared before running the commands.

Run the following Docker commands strictly in this order:

1. Validate the changed local specification:

	```bash
	docker run --rm -t -v $(pwd):/specs tufin/oasdiff validate /specs/path/to/openapi.yaml
	```

2. Generate the changelog against the base branch:

	```bash
	docker run --rm -t -v $(pwd):/specs tufin/oasdiff changelog <(git show main:path/to/openapi.yaml) /specs/path/to/openapi.yaml
	```

3. Check for breaking changes against the same base branch:

	```bash
	docker run --rm -t -v $(pwd):/specs tufin/oasdiff breaking <(git show main:path/to/openapi.yaml) /specs/path/to/openapi.yaml
	```

Replace `main` with `master` in steps 2 and 3 when `main` is not available, and replace `path/to/openapi.yaml` with the actual repository-relative path. Run the commands from the repository root so `$(pwd)` mounts the expected files. The local path must be available below `/specs` inside the container.

If `validate` reports errors, analyze their cause, correct the OpenAPI specification automatically, and rerun the complete sequence from step 1. Do not proceed to `changelog` or `breaking` while validation errors remain.

If `changelog` or `breaking` fails or reports changes, do not stop the process. Continue the required workflow and issue a clear warning to the developer. Include the command failure, reported changes, and affected operations or schemas when available. Treat reported breaking changes as compatibility warnings requiring explicit developer review; never hide or silently reinterpret them.

## Example refactoring patterns

Use patterns such as:

- `#/components/schemas/User` instead of repeated inline user payloads
- `#/components/parameters/PageParam` instead of repeated page query parameter blocks
- `#/components/responses/NotFound` instead of repeated 404 payload definitions
- `oneOf` for strict polymorphic payloads with a small number of meaningful variants
- `allOf` only when composition is genuinely needed and remains readable

## Final instruction

Refactor the supplied OpenAPI document using the smallest correct, modern OpenAPI 3.1 approach that reduces complexity while preserving the contract unless the user explicitly approves a breaking change. Provide the updated spec and a short summary of the main simplifications.
