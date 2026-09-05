---
name: Java 25+ and Ecosystem Standards
description: "Use when writing, reviewing, refactoring, testing, or configuring Java 25+ applications, Spring Boot, Quarkus, Maven, Gradle, Mockito, or Testcontainers."
applyTo: "**/*.java,**/pom.xml,**/build.gradle,**/build.gradle.kts,**/application*.yml,**/application*.yaml,**/*.kt"
---

# Java 25+ Ecosystem Standards

## Scope and priorities

- Apply these rules to Java source, tests, build files, and Spring Boot or Quarkus configuration.
- Preserve the existing public contract, project conventions, and supported runtime unless the task explicitly changes them.
- Prefer the simplest design that is correct, observable, secure, and easy to maintain.
- Verify the project's actual Java, framework, JUnit, Mockito, and Testcontainers versions before using version-specific APIs.
- Resolve conflicts in this order: explicit user requirements, repository conventions, these standards, then general style preferences.

## Architecture & Coding Standards

- Use records consistently for immutable DTOs and value objects. Use a class only when identity, mutability, inheritance, or framework requirements require it.
- Use pattern matching for `instanceof` and `switch`, as well as switch expressions, when this removes casts, flag fields, or nested conditions.
- Use sealed interfaces or classes for closed domain hierarchies and ensure switch expressions cover every permitted variant.
- Use virtual threads by default for I/O-bound workloads and blocking tasks. Define timeouts, cancellation, and failure semantics; do not use them as a substitute for CPU scaling and avoid pinning through long `synchronized` blocks or native calls.
- Use structured concurrency when dependent tasks must be started, completed, or cancelled as a unit and the project version supports it.
- Keep methods small, use guard clauses, and separate validation, orchestration, persistence, and presentation.
- Use constructor injection exclusively and stateless components by default. Make state, lifecycle, and thread-safety requirements explicit when state is necessary.
- Prefer standard Java and framework facilities. Use Lombok or MapStruct only when established by repository convention or when they clearly reduce repetitive code.
- Do not introduce speculative abstractions, global mutable state, unnecessary reflection, or blocking calls into reactive flows.

## Spring Boot 4+ Patterns

- Use current Spring Boot 4+ or Quarkus conventions supported by the repository; do not upgrade frameworks as part of an unrelated change.
- Use constructor injection exclusively. Avoid field-level `@Autowired` and setter injection.
- Define configuration with `@ConfigurationProperties` and validated immutable records instead of mutable beans or scattered `@Value` fields.
- Keep web, application, domain, and infrastructure boundaries visible. Use ports or interfaces at real external boundaries, not for every class.
- Use Spring Data repositories for persistence and Flyway or Liquibase for versioned database migrations. Do not change schemas implicitly through automatic DDL generation in production.
- Disable Open-Session-in-View and load required data within explicit transaction boundaries. Avoid lazy loading in the REST response path.
- Use declarative HTTP clients through `@HttpExchange` for external REST communication. Define timeouts, error mapping, idempotency, and retry policies explicitly.
- Handle REST errors centrally with `@RestControllerAdvice` and `ProblemDetail` following RFC 7807. Do not leak internal stack traces, credentials, or sensitive payloads.
- Validate OAuth2/OIDC tokens with issuer, signature, audience, expiry, and clock-skew checks. Map roles and claims explicitly and authorize according to least privilege.
- Instrument relevant business and infrastructure boundaries with Micrometer Observability. Use consistent metric names, tracing context, and structured logs without secrets or personal data.
- Account for AOT and GraalVM Native Image compatibility: prefer static configuration and register required reflection, proxy, or resource hints explicitly.
- Deny by default for protected endpoints. Do not disable TLS verification, CSRF protection, token validation, or authorization to simplify tests or local development.

## Testing Standards (Mockito & Testcontainers)

- Use JUnit 6+ and AssertJ when supported by the build. Keep tests deterministic, isolated, and focused on observable behavior.
- Initialize Mockito unit tests with `@ExtendWith(MockitoExtension.class)` and configure `@MockitoSettings(strictness = Strictness.STRICT_STUBS)`; remove unused stubs.
- Mock only slow, nondeterministic, external, or independently owned collaborators. Use real records, value objects, collections, and pure domain logic.
- Use `when(...).thenReturn(...)` for stable stubs, `thenThrow(...)` for failure paths, and `verify(...)` only for meaningful external side effects.
- Keep Mockito matchers type-safe and consistent within each invocation. Avoid broad `any()`, deep stubs, `reset`, private/static mocking, and `verifyNoMoreInteractions` without a justified legacy exception.
- Use `ArgumentCaptor` only when the captured value is part of the behavior under test. Mock records or sealed types only at real external boundaries; otherwise use concrete variants.
- Use Testcontainers for real database, broker, cache, or service integration instead of semantically different in-memory substitutes.
- Prefer `@ServiceConnection`; alternatively use `@DynamicPropertySource` with `DynamicPropertyRegistry` to register container configuration before application context initialization.
- Control container lifecycles through Testcontainers/JUnit. Use class-level lifecycle for immutable shared fixtures and method-level lifecycle for stateful or isolation-critical tests.
- Ensure container isolation through dedicated databases, schemas, topics, or cleanup strategies. Pin images and use meaningful readiness checks instead of `latest` or arbitrary sleeps.
- Use reusable containers only for explicitly enabled local feedback loops. Never rely on reuse in CI, and keep tests correct when reuse is disabled.
- Start container tests only for integration behavior; test business logic with fast unit tests and test framework wiring, serialization, transactions, and security with appropriate slice or integration tests.

## Code Style & Guardrails

- Preserve public contracts, repository conventions, and supported runtimes unless the task explicitly changes them.
- Manage dependency versions through existing BOMs, version catalogs, or parent builds. Do not suppress compiler, static analysis, or test failures without a documented reason and clear scope.
- Run the narrowest relevant test first, then the module suite, and finally the usual verification task when practical.
- Test affected success, validation, authorization, timeout, cancellation, persistence, and external-service failure paths.
- Avoid obsolete Java, Spring, Quarkus, JUnit, or Mockito patterns, broad security scopes, mutable shared fixtures, flaky timing assumptions, and arbitrary sleeps.
- Prefer simple, explicit solutions with guard clauses and at most two nesting levels. Do not add unnecessary abstractions or duplicate production logic in tests.
