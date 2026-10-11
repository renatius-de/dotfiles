---
name: dockerfile-optimizer
description: "Use GitHub Copilot to analyze, optimize, complete, and validate Dockerfiles."
applyTo: "**/Dockerfile,**/Dockerfile.*,**/dockerfile,**/dockerfile.*"
---

# Dockerfile Optimization

## Scope

Apply these rules when a task concerns a Dockerfile. For the detailed discovery, optimization, and validation workflow, use the `dockerfile-optimizer-validator` skill.

## Required behavior

- Preserve the application's build and runtime contract; inspect relevant build context, `.dockerignore`, Compose files, manifests, and startup configuration when needed.
- If multiple candidate Dockerfiles exist, list them and ask which one to use. Exclude generated, vendored, dependency, and hidden-directory copies unless requested.
- Evaluate multi-stage builds, useful layer caching, compatible pinned base images, non-root execution, build-context exclusions, package-cache cleanup, and runtime metadata.
- Derive ports, health checks, users, packages, and startup commands from project evidence. Ask rather than guess when compatibility or behavior is unclear.
- Keep changes focused and do not expose secrets in files, image layers, arguments, logs, or reports.

## Validation and safety

- Ask for explicit permission before running commands that build images or start containers.
- Preserve compatibility unless the user approves a breaking change. Report assumptions, unavailable checks, and remaining risks accurately.
- Keep repository guidance and generated output in English.

Follow the skill's validation and reporting checklist; do not claim a build or runtime result unless it was actually observed.
