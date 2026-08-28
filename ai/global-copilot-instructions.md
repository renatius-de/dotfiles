# STRICT OPERATIONAL RULES FOR GITHUB COPILOT

## 1. Zero-Assumption & Clarification Protocol (HIGHEST PRIORITY)
- NEVER make assumptions. If any requirement, architectural pattern, library version, variable type, API contract, or edge case is ambiguous or missing, STOP immediately.
- DO NOT generate speculative code or guess business logic.
- ALWAYS ask direct, concise clarifying questions to obtain the missing information before writing or modifying code.
- If multiple valid technical approaches exist, present them as distinct options and ask for selection instead of choosing one arbitrarily.

## 2. Direct Execution Mode
- Once all necessary information is clarified and confirmed, perform and execute code changes IMMEDIATELY without unnecessary explanations or fluff.
- Provide clean, production-ready code edits right away.

## 3. Language & Documentation Standard
- ALL project documentation, inline code comments, docstrings, commit messages, and README updates MUST be written strictly in ENGLISH.
- Responses in the chat window can remain in German if the user speaks German, but any code artifact or documentation generated MUST be strictly in English.

## 4. README & Documentation Governance
- Check if project documentation or `README.md` files need updates whenever code or behavior changes.
- DO NOT edit `README.md` automatically without confirmation. ALWAYS ask the user explicitly before modifying or creating any `README.md` files.

## 5. General Code Quality & Complexity Reduction (ALL LANGUAGES)
- **Complexity Reduction:** Actively reduce cyclomatic and cognitive complexity in all programming languages. Avoid deep nesting (maximum 2 levels), use early exits (guard clauses), modularize complex logic into small single-responsibility functions, and favor declarative/functional programming constructs where appropriate.
- **Meaningful English Error Messages:** Write explicit, highly context-aware error messages, exception strings, and logs in ENGLISH for all programming languages. Exceptions and log outputs must clearly describe *what* failed, *why* it failed, and *which input/context* triggered the issue (e.g., including variable values, IDs, or inputs) without leaking sensitive security data. Generic messages (such as "An error occurred" or "Invalid input") are strictly forbidden.

## 6. Java 25+ & Ecosystem Standards
When working on Java projects, adhere to modern standards (Java 25+ ecosystem):
- **Core Java Features:** Utilize modern language constructs (Virtual Threads / Structured Concurrency, Pattern Matching, Sealed Classes/Interfaces, Records, and Enhanced Switch Expressions).
- **Spring Boot 4+ & Quarkus:** Follow current idiomatic standards for Spring Boot 4+ and Quarkus. Prefer constructor injection, reactive/virtual-thread-friendly patterns, clean architecture, and stateless bean configurations.
- **Security:** Follow modern OAuth2 / OIDC best practices with **Keycloak** integration (secure token validation, structured role/claim mapping, tight security filters, and stateless authorization).
- **Boilerplate Reduction:** Use **Lombok** (`@Getter`, `@Setter`, `@RequiredArgsConstructor`, `@Builder`, etc.) to eliminate repetitive boilerplate code cleanly.
- **Object Mapping:** Use **MapStruct** for object-to-object/DTO mappings (`@Mapper(componentModel = "spring")` or CDI equivalent). Avoid writing manual mapping methods when MapStruct can generate them safely.
- **Testing Standard:**
  - Target **JUnit 6+** structures.
  - Strongly PREFER **AssertJ** fluent assertions (`assertThat(...)`) over standard JUnit assertions for readable test verification.
  - Use **Mockito** for isolating dependencies, stubbing behavior, and verifying interactions cleanly.
