---
name: makefile-optimizer
description: "Use when analyzing or optimizing existing GNU Make Makefiles, consolidating repeated targets into an existing common.mk, or reducing a Makefile to the core clean, install, and upgrade targets without breaking its workflow."
---

# Optimize GNU Makefiles

Use this skill to analyze existing project Makefiles, reduce duplication, and move genuinely shared behavior into the repository's existing `common.mk`. Keep each target Makefile small, predictable, and compatible with the project's established installation flow.

## Use When

Trigger this skill when the user asks to:

- optimize, simplify, modernize, or review one or more existing GNU Makefiles
- identify duplicated targets, variables, recipes, or helper definitions
- extract shared Make logic into an existing `common.mk`
- reduce a Makefile to its essential lifecycle targets
- preserve or improve the `clean`, `install`, or `upgrade` workflow

Do not create a new shared Makefile abstraction when the project does not already provide a suitable `common.mk`, unless the user explicitly requests that change.

## Goal

Produce a maintainable Makefile structure in which:

- shared variables, functions, flags, and recipes live in the existing `common.mk`
- module-specific Makefiles contain only behavior owned by that module
- each target Makefile is as small as practical
- the target surface is preferably limited to `clean`, `install`, and `upgrade`, plus the required `include common.mk` statement
- existing installation, cleanup, upgrade, path, permission, and error-handling behavior remains intact
- recipes remain safe to rerun and follow the repository's GNU Make conventions

The three-target shape is a target state, not permission to remove behavior that cannot be represented safely through those targets. Preserve necessary module-specific targets when removing them would change the public workflow.

## Required Working Method

### 1. Establish the project contract

Before editing, inspect:

- the root `Makefile`
- the existing `common.mk` and all files it includes
- every relevant module Makefile and its callers
- repository instructions and nearby documentation describing Make targets
- target dependencies, variables, environment assumptions, filesystem paths, and shell behavior

Determine which targets are public entry points and which are internal helpers. Treat the root orchestration and established symlink or installation model as compatibility requirements.

### 2. Inventory duplication and ownership

Compare the Makefiles and record repeated or nearly repeated:

- variable assignments and tool discovery
- `.PHONY` declarations and target dependency patterns
- shell flags, command wrappers, status output, and failure handling
- directory creation, file installation, copying, removal, downloading, and repository update recipes
- help, clean, install, and upgrade behavior
- path calculations and root-directory detection

Classify each item as shared infrastructure, module-specific behavior, or accidental duplication. Move an item to `common.mk` only when it is generic, used by multiple Makefiles, and has one clear contract.

Do not move logic merely because it is long. Keep domain-specific paths, package lists, symlink mappings, and module-specific recipes in their owning Makefile.

### 3. Design the smallest safe structure

For each target Makefile:

- keep `include` statements and module-specific declarations explicit
- use the existing shared helpers instead of duplicating shell logic
- preserve target names and dependency ordering unless a compatible replacement is proven
- make `clean`, `install`, and `upgrade` the public lifecycle targets where technically and semantically possible
- retain only necessary private prerequisites or helper definitions
- remove obsolete variables, recipes, and targets after their callers are migrated
- use `.PHONY` for lifecycle targets and any non-file targets that remain
- keep recipe lines tab-indented and consistent with the repository style

For `common.mk`:

- centralize only reusable behavior
- use explicit, descriptive variable and function names
- preserve the existing shell flags, directory conventions, error reporting, and output style
- avoid module-specific conditionals that make the shared file harder to understand
- avoid silently overriding variables intentionally owned by a module
- keep shared helpers idempotent and safe to invoke from different Makefile locations

### 4. Preserve behavior while refactoring

Check every moved or removed target for:

- callers from the root Makefile, subdirectories, scripts, and documented commands
- dependencies that would otherwise run in a different order
- relative paths that depend on the current Makefile location
- environment variables and required external commands
- file permissions, symlink behavior, and cleanup scope
- shell exit behavior, pipelines, and failure messages
- recursive `make` invocation and the correct working directory

If a target cannot be removed without changing a supported workflow, keep it and explain why. Do not guess at undocumented business behavior or silently introduce a breaking target rename.

### 5. Implement the refactoring

Make the smallest coherent set of edits:

1. Add or adapt reusable helpers in the existing `common.mk`.
2. Update target Makefiles to include and use those helpers.
3. Reduce each target Makefile to module ownership and the lifecycle targets where possible.
4. Remove only definitions that are demonstrably unused after migration.
5. Keep unrelated formatting and behavior unchanged.

Do not create a second `common.mk`, duplicate an existing helper under a new name, or replace a clear recipe with an over-abstracted macro.

### 6. Verify the result

Run the narrowest useful checks first, then broaden them as practical:

- parse every changed Makefile with `make -n` or an equivalent dry run
- inspect the expanded commands for `clean`, `install`, and `upgrade`
- verify that recursive invocations resolve the intended root and module directories
- use `make -n install`, `make -n upgrade`, and `make -n clean` at the root when available
- run repository-provided Makefile checks or shell checks
- execute a real target only when it is safe, expected, and does not modify user data unexpectedly
- confirm that no required target, variable, helper, path, permission, or failure behavior was lost

A dry run is not sufficient if it hides shell errors or skips important runtime conditions. Report checks that could not be run and why.

## Decision Rules

- Prefer reuse of the existing `common.mk` over new abstractions.
- Prefer guard clauses, direct target dependencies, and simple recipes over deeply nested shell conditionals.
- Prefer a smaller target surface, but preserve a target when its removal would break a documented or observed caller.
- Preserve compatibility unless the user explicitly approves a breaking change.
- Ask a focused clarification question when the intended public targets, supported platforms, or acceptable behavior changes are ambiguous.
- Stop and report the conflict when a requested simplification would break the installation model or cannot be validated safely.

## Expected Output

After completing the work, report:

1. which Makefiles and shared helpers were changed
2. which duplicated logic was consolidated into `common.mk`
3. which targets remain in each Makefile and why any extra target was retained
4. how compatibility and target behavior were verified
5. any unresolved assumptions, skipped commands, or remaining duplication

## Quality Bar

The result should be:

- valid GNU Make syntax
- minimal without hiding module behavior
- consistent with the repository's existing `common.mk` and installation flow
- explicit about target ownership and dependencies
- safe to rerun
- clear about failures
- verified with dry runs or executable Makefile checks

## Final Instruction

Analyze the supplied Makefiles first, then refactor them using the smallest correct GNU Make design. Consolidate only truly shared behavior into the existing `common.mk`, keep module Makefiles focused, and reduce their public interface to `clean`, `install`, and `upgrade` whenever that preserves the established workflow. Validate the resulting target graph and report any compatibility limitation instead of guessing.
