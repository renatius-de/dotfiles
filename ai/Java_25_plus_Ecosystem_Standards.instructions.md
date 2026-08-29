---
name: Java 25+ and Ecosystem Standards
description: "Use when working on Java projects; prefer modern Java and Spring Boot patterns, clear security configuration, and strong testing conventions."
applyTo: "**/*.java,**/pom.xml,**/build.gradle,**/build.gradle.kts,**/application*.yml,**/application*.yaml,**/*.kt"
---
- Follow Java 25+ idiomatic patterns for all Java work, including records, sealed types, pattern matching, enhanced switch expressions, and structured concurrency where appropriate.
- Prefer modern Spring Boot 4+ or Quarkus conventions and favor constructor injection, stateless beans, and clean architecture boundaries.
- Keep security configuration aligned with modern OAuth2/OIDC and Keycloak best practices, including secure token validation, explicit role and claim mapping, and strict authorization rules.
- Reduce repetitive boilerplate with Lombok for common DTO and model patterns where appropriate.
- Use MapStruct for object mapping instead of handwritten repetitive mapping code when it is safe and straightforward.
- Prefer AssertJ fluent assertions and JUnit 6+ structures for tests.
- Use Mockito for dependency isolation, stubbing, and interaction verification in unit tests.
- Keep test code readable, focused, and behavior-oriented rather than mock-heavy or over-specified.
