---
name: liquibase-migration-author-review
description: "Author and review Liquibase changelogs with safe schema evolution, explicit rollback decisions, and database-aware validation."
---

# Author and Review Liquibase Migrations

Use this skill when creating, changing, or reviewing Liquibase changelogs and database migrations. Apply it to the repository's existing Liquibase setup without assuming a database, Liquibase version, changelog format, deployment model, or rollback policy.

## Scope and safety

- Inspect the repository's changelog, Liquibase configuration, dependency or plugin version, database configuration, deployment workflow, and tests before proposing migration syntax or commands.
- Follow the established changelog format and structure. Liquibase supports XML, YAML, JSON, and formatted SQL; do not convert formats or introduce a new one without an explicit requirement.
- Confirm the target database and supported version from project configuration. Use only syntax and Liquibase features supported by those versions; do not claim cross-database compatibility without validation.
- Do not connect to, update, roll back, or otherwise modify a shared or production database without explicit authorization.
- Do not expose credentials, connection strings, production data, or sensitive migration output.
- If an essential requirement remains unknown—such as the target database/version, data transformation, deployment order, downtime tolerance, or destructive-change approval—ask a concise clarifying question before authoring or approving the change.

## Required workflow

### 1. Establish the migration contract

Before editing or reviewing:

- Locate the root changelog, included changelogs, changelog search paths, Liquibase configuration, and any contexts or labels selected by deployment.
- Identify the Liquibase version, target database/version, and relevant build, test, and deployment commands from repository evidence.
- Read the affected schema, existing data assumptions, application mappings and queries, neighboring changesets, and database tests.
- Determine whether the change must support existing installations, rolling application deployments, multiple database engines, or particular data volumes.
- Check whether the candidate changeset may already have been deployed. Treat deployment records and repository history as evidence; when deployment status cannot be established, do not assume the changeset is safe to edit.
- Ask for missing business rules, rollout constraints, or approval for data loss and destructive operations instead of inventing them.

### 2. Author focused, stable changesets

- Make each changeset one logical, reviewable database change. Split independent schema changes, long-running data work, and expand-and-contract rollout stages when doing so improves safety or deployment control.
- Give each changeset an immutable, unique, traceable `id` and `author`; follow the repository's naming and authorship conventions. Remember that Liquibase identifies a changeset using its `id`, `author`, and changelog file path.
- Never edit, rename, move, or renumber a changeset that may have been deployed. Add a new corrective changeset. If an undeployed changeset is being revised, first verify its deployment status and follow repository policy.
- Preserve include ordering and changelog paths; changing a path can affect changeset identity. Do not reorder or relocate changelogs without understanding the effect on deployed databases.
- Use `runOnChange`, `runAlways`, `validCheckSum`, and similar checksum or rerun controls only when the intended repeat behavior is understood, justified, and consistent with project policy. They are not general fixes for editing deployed changesets or checksum errors.
- Prefer native Liquibase change types when they clearly express the operation and are supported by the configured Liquibase/database versions. Use database-specific SQL when required, and make its dialect and portability limits explicit.
- Keep each changeset deterministic and narrow. Avoid hidden environment-specific values, unbounded data transformations, and broad conditional DDL that masks unexpected schema drift.

### 3. Evolve schema and data safely

- Prefer additive, backward-compatible changes first when old and new application versions may overlap. Use expand, application transition, backfill, and contract phases as appropriate; remove obsolete schema only after compatibility and data-retention requirements are confirmed.
- Assess table size, lock and table-rewrite behavior, transaction boundaries, index build impact, constraint validation, replication effects, and deployment duration for the actual database and operation.
- Design data updates and backfills for the real data shape and volume. Consider batching, progress, interruption, retries, idempotency, and whether the change can safely run within Liquibase's transaction behavior.
- Check existing rows and data quality before adding `NOT NULL`, uniqueness, foreign-key, or check constraints. Use staged validation or backfill steps when required by the database or rollout contract.
- Do not drop, truncate, overwrite, or irreversibly transform data without an explicit requirement, understood impact, and required approval. Preserve data unless its removal is intentional.
- Consider database-specific index and constraint features only after verifying their supported syntax and operational behavior. Do not assume an operation is online, non-blocking, or portable from its Liquibase change type alone.

### 4. Use preconditions, contexts, and labels deliberately

- Add preconditions when they protect a documented invariant or make applicability explicit. Choose `onFail` and `onError` behavior intentionally and describe the operational consequence.
- Treat `MARK_RAN` and other skip-like outcomes as consequential: use them only when skipping the operation is correct and observable. Never use preconditions to silently conceal drift or make an unsafe migration appear successful.
- Scope preconditions to the specific object or state they must verify. Avoid brittle checks that merely restate assumptions or can pass for the wrong schema, catalog, or environment.
- Use `context` and `labels` only when the repository has a clear selection convention or the change has a real, documented need for selective execution. Verify how deployment commands select them and what happens when filters are omitted.
- Do not treat contexts, labels, or preconditions as authorization controls or substitutes for review and environment safeguards.

### 5. Decide and verify rollback behavior

- For each changeset, assess whether rollback is safe, complete, and meaningful for both schema and data.
- Provide an explicit rollback when the operation can be reversed without losing user data or violating application invariants. Use the repository's established rollback style and verify that it reverses the intended change.
- Do not claim that a destructive rollback is safe merely because Liquibase can execute its statements. Consider data written after deployment, transformed values, dependencies, and mixed application versions.
- If a safe rollback is not possible or not appropriate, document why and identify the forward-fix or recovery approach. Treat irreversible data changes as a deliberate operational decision, not an implicit rollback policy.
- Do not run rollback against a shared or production database without explicit authorization. Validate rollback behavior in an isolated database when feasible.

### 6. Review existing or proposed changesets

Review the full changelog context and report actionable findings. Check:

- **Identity and history:** Is the `id`/`author` unique and traceable? Is any possibly deployed changeset edited, moved, or otherwise subject to identity/checksum changes?
- **Intent and scope:** Does each changeset implement one clear requirement without unrelated schema or data changes?
- **Compatibility:** Can the schema coexist with application versions during the stated rollout? Are dependent application mappings, queries, and deployment steps aligned?
- **Data safety:** Are pre-existing rows accounted for? Could the operation lose, corrupt, or unexpectedly alter data?
- **Operational impact:** Are locks, rewrites, index builds, transaction size, backfill duration, and database-specific behavior understood?
- **Constraints and indexes:** Are nullability, defaults, keys, uniqueness, foreign keys, checks, and index definitions correct for existing data and the target engine?
- **Guardrails:** Are preconditions appropriate and their failure/error behavior explicit? Are contexts and labels necessary and consistent with deployment filters?
- **Rollback:** Is rollback explicit and safe where feasible? If not, is the non-rollbackable or forward-fix rationale and recovery plan clear?
- **Execution and validation:** Are format, syntax, Liquibase/database feature support, include order, and relevant tests or update output validated?
- **Scope hygiene:** Are credentials, production data, unrelated changes, and undocumented environment-specific behavior absent?

Prioritize findings by deployment impact. For each finding, identify the changeset and affected object or operation, explain the concrete failure mode, and recommend a specific correction. Separate verified defects from questions or risks that depend on unavailable deployment or database evidence.

### 7. Validate using the repository's tooling

- Use the repository's wrapper, configured Liquibase plugin/CLI, and documented commands. Do not guess command-line options or install a different Liquibase version.
- Validate changelog parsing and, where available, generate or inspect the SQL for the actual target database and selected contexts/labels.
- Run migration tests against an isolated database using the supported engine/version. Test both a fresh installation and an upgrade from the prior supported schema when both paths are in scope.
- Verify representative existing data, constraints, application compatibility, and rollback or forward-fix behavior relevant to the change.
- Review generated SQL for lock, transaction, dialect, and destructive-operation implications. Generated SQL is not proof that the migration succeeded on the target database.
- Do not use `clearCheckSums`, manual changelog-table edits, or similar repair mechanisms as a routine response to a checksum mismatch. Diagnose deployment history and follow the project's controlled repair process.
- If the target database, version, or environment is unavailable, state which checks could not be run and do not claim database-backed validation.

## Decision rules

- Preserve the repository's chosen changelog format, Liquibase version, naming conventions, and database contract.
- Do not infer the dialect, production deployment state, data volume, downtime allowance, or rollback guarantee.
- Treat deployed changesets as immutable; correct them with new changesets.
- Require explicit approval for destructive or irreversible data/schema changes and for operations on shared or production environments.
- Prefer the smallest safe change that satisfies the requirement. Ask when a missing fact changes migration design or safety.

## Expected output

For authoring, provide the new changeset(s), rollback decision, rollout and operational considerations, and exact validation performed.

For review, report findings first, ordered by severity, with changeset identity, concrete impact, and recommended action. Then summarize positive checks, validation performed, unavailable checks, and remaining questions or risks. Do not report a clean review when a material risk remains unverified.

## Completion criteria

A migration task is complete when changeset identity and deployment history are preserved, the schema/data and rollout effects are understood, rollback or forward-fix behavior is explicit, repository-appropriate validation has been run where available, and unresolved risks are clearly reported.
