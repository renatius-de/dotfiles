---
name: docker-compose-optimizer
description: "Use GitHub Copilot to analyze, optimize, complete, and validate Docker Compose configurations."
applyTo: "**/docker-compose*.yml,**/docker-compose*.yaml,**/compose.yml,**/compose.yaml"
---

# Docker Compose Optimization

## Scope

Apply these rules when a task concerns a Docker Compose configuration. For the detailed discovery, optimization, and validation workflow, use the `docker-compose-optimizer-validator` skill.

## Required behavior

- Preserve service intent and inspect referenced variables, build contexts, Dockerfiles, and nearby configuration when needed.
- If multiple candidate Compose files exist, list them and ask which one to use. Exclude generated, vendored, dependency, and hidden-directory copies unless requested.
- Evaluate syntax, obsolete fields, image pinning, secrets, resource limits, persistence, health checks, networks, port exposure, and logging only where project evidence supports a change.
- Do not invent services, versions, credentials, limits, ports, or persistence behavior. Keep changes focused and explain compatibility-sensitive effects.

## Validation and safety

- Validate configuration with `docker compose config` when available. Ask for explicit permission before starting services or performing data-impacting operations.
- Never expose secret values in files, logs, diffs, or reports. Preserve compatibility unless the user approves a breaking change.
- Follow the skill's reporting checklist and distinguish verified results from unavailable checks and assumptions.
