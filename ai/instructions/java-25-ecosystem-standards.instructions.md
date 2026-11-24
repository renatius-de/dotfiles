---
name: java-25-ecosystem-standards
description: "Use when writing, reviewing, refactoring, testing, or configuring Java 25+ applications, Spring Boot, Quarkus, Maven, Gradle, Mockito, Testcontainers, and JUnit 6+."
applyTo: "**/*.java,**/pom.xml,**/build.gradle,**/build.gradle.kts,**/application*.yml,**/application*.yaml,**/*.kt"
---

# Java 25+ Ecosystem Standards

## Scope and priorities

Apply to Java source/tests, build files, and Spring Boot/Quarkus configuration. Preserve public contracts, repository conventions, and supported runtime unless explicitly changed; prefer the simplest correct, observable, secure, maintainable design. Verify actual Java/framework/JUnit/Mockito/Testcontainers versions before using version-specific APIs. Resolve conflicts by priority: user requirements, repository conventions, these standards, general style. This rule covers Java implementation/testing, not OpenAPI, README approval, or documentation language.

## Architecture & coding standards

- Use records for immutable DTOs/value objects unless identity, mutability, inheritance, or framework needs require classes. Use `instanceof`/`switch` pattern matching and switch expressions to remove casts, flags, or nesting; use sealed types for closed hierarchies and exhaustively handle variants.
- Default to virtual threads for I/O-bound/blocking work; define timeout, cancellation, and failure behavior; never use them for CPU scaling or pin them with long `synchronized`/native calls. Use structured concurrency for dependent task groups when supported.
- Keep methods small, use guards, and separate validation, orchestration, persistence, and presentation. Use constructor injection and stateless components by default; make necessary state/lifecycle/thread-safety explicit.
- Prefer standard facilities; use Lombok/MapStruct only when established or clearly reducing repetition. Avoid speculative abstractions, global mutable state, needless reflection, and blocking in reactive flows.

## Stream API standards

- Prefer the Stream API for declarative, non-mutating data transformation and query pipelines, especially filtering, mapping, grouping, sorting, aggregation, and short-circuit searches. Prefer traditional loops when mutation, complex control flow, early stateful decisions, or measured primitive-loop performance makes a loop clearer or materially more efficient.
- Use `java.util.stream.Gatherers` for custom intermediate operations instead of implementing comparable stateful behavior with side-effecting lambdas or terminal collectors. Use built-in gatherers when they express the operation directly, and prefer reusable named gatherer implementations for custom windowing, folding, scanning, or filtering behavior.
- Keep gatherers and all lambda expressions passed to stream pipelines free of externally visible side effects. Do not mutate collections, fields, atomics, counters, I/O resources, logs, or other shared state from `map`, `filter`, `flatMap`, `peek`, `forEach`, or custom gatherer operations. Preserve encounter order unless a documented operation explicitly requires unordered processing.
- Treat a stream pipeline as a lazy, functional transformation. Prefer terminal collectors or `Optional`/primitive-stream results over lambda-driven mutation. Use `forEach` only at an explicit external boundary such as rendering, notification, or persistence, and make each side effect deliberate and isolated.
- Keep pipelines allocation-conscious: avoid unnecessary `map`/`boxed` steps, prefer `IntStream`, `LongStream`, or `DoubleStream` for primitive-heavy transformations, and use primitive reductions or specialized collectors instead of repeatedly boxing values. Do not create intermediate collections as accidental implementation detail when lazy operations or a single terminal collector can express the result directly.
- Do not enable parallel streams by default. Parallelize only after confirming sufficient, independent work, splittability, ordered semantics, thread safety, and measurable benefit. Use virtual threads or structured concurrency for blocking I/O rather than `parallelStream()`; never pass blocking or shared-mutable operations to a parallel stream.
- Before adding or retaining a stream pipeline, verify its data volume and cost when performance is measurable or sensitive. Benchmark representative inputs and avoid assumptions based on micro-benchmarks, stream syntax, or parallelism.
- Require stream sources to be non-null before creating a pipeline. Fail fast with `Objects.requireNonNull(...)` for method parameters or dependencies that must exist; use `Stream.empty()`, `Optional.empty()`, or `Collections::empty...` for legitimate absent data rather than `null` sources.
- Handle null elements explicitly: use `Stream.ofNullable(...)` for a known optional element or `filter(Objects::nonNull)` only when absent elements are intentionally permitted and not representable as `Optional`. Do not silently include `null` elements in maps or collections, and do not assume downstream framework code can safely process them.
- Keep null handling explicit at every intermediate boundary. Validate or normalize inputs before `map`/`flatMap`, prefer `Optional` at a genuine absence boundary, and avoid `Optional.map` chains that hide malformed or duplicate data. If a custom gatherer or collector is designed to accept null elements, document that contract and validate it with tests.
- Define terminal-result nullability explicitly. Prefer immutable collection results such as `toList()`, an empty primitive/container result, or `Optional` for zero-or-one results; never rely on a terminal result being `null` when absence can be expressed structurally. Do not use `Optional.get()` without prior presence validation or map a terminal absence to `null` without an explicit API contract.

## Spring Boot 4+ patterns

- Follow repository-supported Spring Boot 4+/Quarkus conventions; do not upgrade frameworks as unrelated work.
- Use constructor injection only, never field `@Autowired` or setter injection. Define validated immutable-record configuration with `@ConfigurationProperties`, not mutable beans or scattered `@Value`.
- Keep web, application, domain, and infrastructure boundaries visible; use ports/interfaces at actual external boundaries, not everywhere.
- Use Spring Data repositories and versioned Flyway/Liquibase migrations; never rely on automatic production DDL generation.
- Disable Open-Session-in-View; load needed data within explicit transactions and avoid lazy loading in REST response paths.
- Use declarative HTTP clients through `@HttpExchange` for external REST communication. Define timeouts, error mapping, idempotency, and retry policies explicitly.
- Handle REST errors centrally with `@RestControllerAdvice` and RFC 7807 `ProblemDetail`; never leak stack traces, credentials, or sensitive payloads.
- Validate OAuth2/OIDC tokens with issuer, signature, audience, expiry, and clock-skew checks. Map roles and claims explicitly and authorize according to least privilege.
- Instrument relevant business and infrastructure boundaries with Micrometer Observability. Use consistent metric names, tracing context, and structured logs without secrets or personal data.
- Account for AOT and GraalVM Native Image compatibility: prefer static configuration and register required reflection, proxy, or resource hints explicitly.
- Deny protected endpoints by default. Never disable TLS verification, CSRF, token validation, or authorization for tests or local development.

## Testing standards: AssertJ, Mockito, JUnit 6+, and Testcontainers

### Assertion style and test philosophy

- Use AssertJ as the mandatory assertion library for Java tests. Do not use classic JUnit assertions such as `assertEquals`, `assertTrue`, `assertFalse`, `assertNull`, `assertNotNull`, or `assertThrows`.
- Prefer fluent AssertJ chaining that reads as one behavioral statement, for example `assertThat(result).isNotNull().extracting(Result::items).asList().containsExactly(expectedItem)`.
- Use type-specific assertions instead of asserting implementation details: write `assertThat(items).isEmpty()` instead of `assertThat(items.size()).isEqualTo(0)`, and prefer `isTrue()`, `isFalse()`, `isNull()`, `isNotNull()`, `containsExactly(...)`, or `hasSize(...)` where they express the subject directly.
- Use descriptive assertion context with `as(...)` or `describedAs(...)` before the terminal assertion when the failure message benefits from domain meaning.
- Use `assertThatThrownBy(...)` for expected exceptions and chain type, message, cause, and field assertions. Use `assertThatCode(...)` when verifying that an operation completes without an exception or when the thrown type is not the primary subject.
- Use `assertSoftly(...)` for multiple independent attributes of one result so all relevant failures are reported together; use regular fluent assertions when one failure makes subsequent checks meaningless.
- Keep tests deterministic, isolated, and focused on observable behavior. Prefer behavior-oriented checks over structural assertions or mocking deep internal interactions.

### JUnit 6+ modern architecture

- Use JUnit 6+ as the default test framework for lifecycle, parameterization, execution, and extension features.
- Prefer modern extension-based test architecture over legacy JUnit 4 patterns. Use `@ExtendWith(...)` and dedicated extension classes for infrastructure concerns such as time control, mocking, or system integration only when they provide real value.
- Keep the test lifecycle explicit and readable: use `@BeforeEach`, `@AfterEach`, `@BeforeAll`, and `@AfterAll` only for genuinely lifecycle-bound setup or cleanup. Do not rely on hidden global state or implicit ordering.
- Prefer `@TestInstance(Lifecycle.PER_METHOD)` by default. Use `PER_CLASS` only when a test class is intentionally stateful and the lifecycle is clearly documented and thread-safe.
- Avoid obsolete JUnit 4 patterns such as `@RunWith`, `@Before`, `@After`, `@Ignore`, `@Category`, and legacy rule-based tests.
- Use native JUnit support for Java Virtual Threads when running I/O-heavy or blocking test workloads. Keep test executors virtual-thread-friendly, avoid long blocking code paths in tests, and ensure deterministic cleanup for resources and external systems.
- Give each test a single responsibility and keep fixtures minimal. A test should explain one scenario, one expected outcome, and one failure mode.
- Prefer `@Nested` classes to express behavior and state transitions within a single domain area, for example `whenOrderIsValid`, `whenCustomerHasNoBalance`, or `whenInputIsMalformed`.
- Use `@Tag` or project-specific naming conventions for test classification when they help separate unit, integration, smoke, or slow tests without creating implicit execution dependencies.
- Use explicit ordering only when required by the domain; prefer fully independent tests and deterministic execution. Do not rely on test order for correctness.
- Configure parallel execution only when the suite is designed for it: use isolated resources, avoid shared mutable state, and document any required synchronization or resource locking.
- Use `@ResourceLock` or similar synchronization mechanisms when parallel tests must share non-thread-safe infrastructure such as file systems, ports, or broker state.

### Parameterized tests and data-driven design

- Use parameterized tests as the default for data-driven validation, especially for boundary values, validation rules, equivalence classes, and cross-product behavior.
- Prefer type-safe argument providers over ad hoc arrays or loosely typed maps. Model inputs as records when the test case contains multiple dimensions or domain-values.
- Use `@MethodSource` for complex or derived test data, especially when the dataset is computed from Java logic or when a record-based payload improves readability and type safety.
- Use `@ParameterizedTest` together with a dedicated record such as `record ValidationCase(String input, String expectedOutput, boolean shouldFail) {}` and return `Stream<Arguments>` or `Stream<ValidationCase>` as appropriate.
- Keep parameter sets small, explicit, and readable. Prefer naming conventions that communicate the scenario, e.g. `validEmail`, `missingDomain`, or `tooLongUsername`.
- When a test case is a single value, prefer `@ValueSource`, `@EnumSource`, or a focused `@MethodSource` over broad combinatorial data sets that hide the real intent.
- Avoid parameterization that hides the domain scenario behind opaque positional arguments. Use record names, `Arguments.of(...)`, and helper factories to keep failure messages meaningful.
- For assertions involving parameterized cases, include the test case data in the assertion context via `describedAs(...)` or `as(...)` so failed inputs remain obvious.

### Nested tests and domain structure

- Use `@Nested` classes to group related scenarios by behavior, state, or boundary condition rather than by framework lifecycle alone.
- Structure tests so a parent class describes the subject under test and inner classes describe the relevant contexts, for example `CustomerServiceTests` with nested classes for `whenCustomerExists`, `whenCustomerDoesNotExist`, and `whenBalanceIsInsufficient`.
- Keep nested classes focused on one dimension of behavior. Avoid deeply nested test hierarchies that obscure the actual scenario.
- Prefer naming nested classes and methods with domain language, not with implementation details such as helper names or internal method signatures.
- Use nested tests to model business states, validation flows, and edge-case partitions, while keeping shared setup in outer classes and scenario-specific setup in inner classes or lifecycle methods.

### Mockito and external collaborators

- Initialize Mockito unit tests with `@ExtendWith(MockitoExtension.class)` and configure `@MockitoSettings(strictness = Strictness.STRICT_STUBS)`; remove unused stubs.
- Mock only slow, nondeterministic, external, or independently owned collaborators. Use real records, value objects, collections, and pure domain logic.
- Use `when(...).thenReturn(...)` for stable stubs, `thenThrow(...)` for failure paths, and `verify(...)` only for meaningful external side effects.
- Keep Mockito matchers type-safe and consistent within each invocation. Avoid broad `any()`, deep stubs, `reset`, private/static mocking, and `verifyNoMoreInteractions` without a justified legacy exception.
- Use `ArgumentCaptor` only when the captured value is part of the behavior under test. Mock records or sealed types only at real external boundaries; otherwise use concrete variants.
- Keep each test free of incidental mocking. If a collaborator is not part of the observable behavior, remove it from the test.

### Testcontainers and integration tests

- Use Testcontainers for real database, broker, cache, or service integration instead of semantically different in-memory substitutes.
- Prefer `@ServiceConnection`; alternatively use `@DynamicPropertySource` with `DynamicPropertyRegistry` to register container configuration before application context initialization.
- Control container lifecycles through Testcontainers/JUnit. Use class-level lifecycle for immutable shared fixtures and method-level lifecycle for stateful or isolation-critical tests.
- Ensure container isolation through dedicated databases, schemas, topics, or cleanup strategies. Pin images and use meaningful readiness checks instead of `latest` or arbitrary sleeps.
- Use reusable containers only for explicitly enabled local feedback loops. Never rely on reuse in CI, and keep tests correct when reuse is disabled.
- Start container tests only for integration behavior; test business logic with fast unit tests and test framework wiring, serialization, transactions, and security with appropriate slice or integration tests.

## Code style & guardrails

- Preserve public contracts, repository conventions, and supported runtimes unless the task explicitly changes them.
- Manage dependency versions through existing BOMs, version catalogs, or parent builds. Do not suppress compiler, static analysis, or test failures without a documented reason and clear scope.
- Run the narrowest relevant test first, then the module suite, and finally the usual verification task when practical.
- Test affected success, validation, authorization, timeout, cancellation, persistence, and external-service failure paths.
- Avoid obsolete Java, Spring, Quarkus, JUnit, or Mockito patterns, broad security scopes, mutable shared fixtures, flaky timing assumptions, and arbitrary sleeps.
- Prefer simple, explicit solutions with guard clauses and at most two nesting levels. Do not add unnecessary abstractions or duplicate production logic in tests.
