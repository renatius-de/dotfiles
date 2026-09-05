---
description: "OpenAPI authoring, validation, and design rules for YAML and JSON specifications."
applyTo: "**/*.openapi.yaml,**/*.openapi.json,**/openapi.yaml,**/swagger.yaml,api/**,docs/spec/**"
---

# OpenAPI Authoring Rules

## Scope

- Apply these rules to all OpenAPI files matching `*.openapi.yaml`, `*.openapi.json`, `openapi.yaml`, `swagger.yaml`, and all files under `api/` and `docs/spec/`.
- Treat all OpenAPI documents as authoritative API contracts and validate them against the OpenAPI 3.0 or 3.1 specification before finalizing changes.
- When editing existing API specs, preserve compatibility unless the change is explicitly approved as a breaking change.

## General format and validity rules

- Use valid OpenAPI 3.0 or 3.1 syntax at all times; do not invent vendor extensions or non-standard fields unless they are explicitly required by the project.
- Prefer YAML over JSON for human-readable API specifications, except when the project explicitly requires JSON.
- Use consistent indentation with exactly 2 spaces for YAML; do not mix tabs or irregular indentation.
- Keep object keys, values, and nesting structurally valid; do not leave trailing commas, malformed arrays, or invalid property declarations.
- Use valid data types for all schemas, including `string`, `integer`, `number`, `boolean`, `array`, and `object` only when they match the actual API contract.
- Keep `openapi`, `info`, `paths`, `components`, and other top-level sections in their required structure and order where practical.
- Ensure all referenced `$ref` targets resolve to valid components and do not create circular or broken references.

## API design best practices

- Use kebab-case for endpoint paths, for example `/user-profiles/{user-id}` and `/audit-logs/{log-id}`.
- Use consistent naming conventions for schemas and properties; choose either camelCase or snake_case and follow it throughout the specification.
- Use HTTP methods consistently: `GET` for retrieval, `POST` for creation, `PUT` or `PATCH` for updates, and `DELETE` for removals.
- Use clear and standard HTTP status codes: `200` for successful reads, `201` for created resources, `204` for successful deletions with no content, `400` for invalid input, `401` for missing authentication, `403` for forbidden access, `404` for missing resources, `409` for conflicts, and `500` for server-side failures.
- Model error responses explicitly through reusable error schemas or response components instead of leaving failures implicit.
- Keep path parameter names aligned with the schema property names and avoid ambiguous or inconsistent identifiers.

## Reusability and DRY principles

- Reuse `components/schemas`, `components/responses`, `components/parameters`, and `components/securitySchemes` instead of duplicating schema or response definitions inline.
- Prefer `$ref` for all repeated structures, especially for common payloads, errors, pagination, pagination metadata, and shared security definitions.
- Keep component names descriptive and domain-specific, for example `UserProfile`, `ErrorResponse`, `PaginationMeta`, or `BearerAuth`.
- Do not duplicate request bodies or response payloads across multiple operations when a shared component can be reused.
- Avoid creating deeply nested, redundant schemas when a reusable, smaller component is clearer and more maintainable.

## Spring Boot 4 and vendor extensions

- OpenAPI 3.0 and 3.1 do not define a universal Spring Boot 4 extension set. Treat every `x-` field as vendor metadata for a named consumer such as springdoc-openapi, a code generator, or an internal platform.
- Before adding or retaining an extension, identify the consuming tool and version, preserve its expected value type and location, and verify that the extension is supported by the project.
- Keep standard OpenAPI fields authoritative when an equivalent exists. Vendor extensions must not replace `tags`, `content`, `security`, `responses`, parameters, or JSON Schema validation keywords.
- Place operation-specific extensions on the operation object, resource-wide metadata on the path item or root document, and enum metadata on the schema that declares the enum. Do not propagate extensions to unrelated operations.

Use the following extensions only when the consuming Spring Boot 4 integration explicitly supports them:

| Extension | Placement and value | Apply when |
| --- | --- | --- |
| `x-tags` | Root document, path item, or operation; use an array of tag strings and keep standard `tags` synchronized when both are present. | A downstream grouping or code-generation tool needs additional tag metadata. Never use it instead of standard `tags`. |
| `x-content-type` | Operation, request body, or response; use the consumer-defined media-type string or list and keep the standard `content` map authoritative. | A Spring integration requires an explicit generated content type that cannot be inferred reliably. The value must match a media type in `content`. |
| `x-spring-paginated` | Operation as a boolean, normally on collection `GET` operations. | The integration generates or recognizes pagination parameters and metadata. Do not add it to item, command, or non-paginated operations. |
| `x-version-param` | Operation as the exact API-version parameter name or the consumer-defined parameter descriptor. Declare the corresponding parameter in `parameters` as well. | Version selection uses a request parameter. Keep its location, type, requiredness, and allowed values consistent with the standard parameter. |
| `x-spring-api-version` | Root document, path item, or operation as the consumer-defined API-version value; use the narrowest correct scope. | A Spring API-versioning integration requires explicit version mapping. Do not use it to silently change an existing version contract. |
| `x-enum-description` | Enum schema as a map keyed by exact enum values, or the exact format required by the consumer. | Generated clients or documentation need descriptions for individual enum values. Every key must exist in the schema's `enum` array. |
| `x-enum-varnames` | Enum schema as an array of strings, one entry per enum value in the same order as `enum`. | Generated clients or documentation need expressive member names for each enum value. The array length and order must exactly match the `enum` array. |

- `x-enum-varnames` must be an array, not a map. Each item corresponds to the enum value at the same index in `enum`, so the array length, order, and item count must match exactly. A mismatch such as a missing entry, reordered values, or a different number of items is invalid and must be corrected.
- `x-enum-description` remains a map keyed by the exact enum values. This is different from `x-enum-varnames`: descriptions are by value, while varnames are positional and ordered. Both extensions can be present together when a consumer needs both human-readable labels and code-friendly member names.
- Example of a valid enum metadata combination:

```yaml
components:
  schemas:
    Status:
      type: string
      enum:
        - ACTIVE
        - ARCHIVED
        - DELETED
      x-enum-varnames:
        - ACTIVE
        - ARCHIVED
        - DELETED
      x-enum-description:
        ACTIVE: "The record is currently active."
        ARCHIVED: "The record is archived and no longer editable."
        DELETED: "The record has been deleted."
```

```json
{
  "components": {
    "schemas": {
      "Status": {
        "type": "string",
        "enum": ["ACTIVE", "ARCHIVED", "DELETED"],
        "x-enum-varnames": ["ACTIVE", "ARCHIVED", "DELETED"],
        "x-enum-description": {
          "ACTIVE": "The record is currently active.",
          "ARCHIVED": "The record is archived and no longer editable.",
          "DELETED": "The record has been deleted."
        }
      }
    }
  }
}
```

- For pagination, versioning, and content negotiation, model the actual HTTP contract with standard fields: declare query or header parameters, media types under `content`, pagination schemas or response links where applicable, and explicit status codes. Vendor metadata must never be the only client-visible representation of behavior.
- For security, use `components/securitySchemes`, operation-level `security`, and explicit scopes or roles. For auditing, use explicit audit schemas, read-only audit fields, and documented audit operations.
- For errors, use reusable `components/responses` and error schemas with stable error codes and documented status codes. For validation, prefer `required`, `pattern`, `format`, `minLength`, `maximum`, `unevaluatedProperties`, and other applicable JSON Schema keywords.
- Add project-specific extensions such as `x-audit-event`, `x-error-code`, `x-validation`, or `x-enum-varnames` only when their schema, owner, supported locations, and consuming tool are documented by the project. Never present them as Spring Boot 4 standards.

## Documentation and quality

- Every operation must include a concise `summary` and a complete `description` that explains purpose, behavior, constraints, and side effects.
- Define an explicit `operationId` for every operation using the format `verbNoun`, for example `getUserProfile`, `createUserProfile`, or `deleteUserProfile`.
- Provide representative `example` or `examples` values for schemas, request bodies, and response payloads whenever a value is meaningful or required for comprehension.
- Use clear, human-readable descriptions for query parameters, headers, and security requirements.
- Document authentication and authorization requirements explicitly with `security` entries or reusable security schemes.
- Keep examples realistic and aligned with the schema; do not use placeholder values that contradict the type or business rules.

## Instructions for Copilot generation behavior

- When creating new endpoints, always generate complete request bodies, response payloads, and error handling for relevant `4xx` and `5xx` cases.
- When creating or editing endpoints, include all required fields, explicit status codes, and realistic data examples; do not leave incomplete or partially described operations.
- Use reusable components first; only inline definitions when they are truly local and not repeated elsewhere.
- Keep all naming, casing, and status code usage consistent across the entire specification.
- Do not introduce breaking changes to existing APIs without an explicit note in a code comment or a clear approval marker in the change context.
- Never remove or silently change existing endpoint contracts, required fields, or response semantics without calling out the risk and the reason.
- Do not invent unsupported authentication schemes, custom response formats, or undocumented business rules.
- Keep generated OpenAPI documents maintainable, compact, and readable; prefer clarity over cleverness.

## Direct implementation rules

- Use YAML unless the repository or existing project conventions explicitly require JSON.
- Use `components` for all shared structures and `securitySchemes` for authentication configuration.
- Define only the minimum required fields for each operation while preserving strong documentation and good examples.
- Validate the final OpenAPI file for structural correctness before considering the work complete.
- If a schema or endpoint is ambiguous, ask for clarification instead of guessing the contract.
