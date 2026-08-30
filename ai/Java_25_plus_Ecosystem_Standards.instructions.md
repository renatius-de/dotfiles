---
name: Java 25+ and Ecosystem Standards
description: "Use when working on Java projects; prefer modern Java and Spring Boot patterns, clear security configuration, and strong testing conventions."
applyTo: "**/*.java,**/pom.xml,**/build.gradle,**/build.gradle.kts,**/application*.yml,**/application*.yaml,**/*.kt"
---

## Scope

- Applies to Java source files, build files, and Spring Boot or Quarkus configuration in this project.
- Use this standard for application code, tests, dependency configuration, and security setup.

## Required behavior

- Use Java 25+ idiomatic patterns where appropriate, including records, sealed types, pattern matching, enhanced switch expressions, and structured concurrency.
- Prefer modern Spring Boot 4+ or Quarkus conventions.
- Use constructor injection and stateless beans unless a stateful design is explicitly required.
- Keep architecture boundaries clear and favor a clean separation of concerns.
- Keep security configuration aligned with modern OAuth2/OIDC and Keycloak practices, including secure token validation, explicit role and claim mapping, and strict authorization rules.
- Reduce repetitive boilerplate with Lombok for common DTO and model patterns when it fits the codebase.
- Use MapStruct for repetitive object mapping instead of handwritten conversion code when it is safe and straightforward.
- Write tests with AssertJ fluent assertions and JUnit 6+ patterns.
- Use Mockito for dependency isolation, stubbing, and interaction verification in unit tests.

## Do not

- Do not use outdated Java patterns or legacy Spring configuration when modern equivalents are available.
- Do not keep broad security scopes, permissive role mappings, or weak token validation.
- Do not write mock-heavy tests that assert implementation details instead of real behavior.
- Do not duplicate mapping logic or repetitive boilerplate when a standard framework solution exists.

## Test and design standard

- Keep test code readable, focused, and behavior-oriented.
- Prefer tests that verify observable outcomes over tests that only confirm mock interactions.
- Prefer explicit, maintainable production code over clever abstractions.
