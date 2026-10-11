---
name: kubernetes-manifest-standards
description: "Use when authoring, reviewing, or validating Kubernetes manifests and Helm charts."
applyTo: "**/k8s/**/*.yaml,**/k8s/**/*.yml,**/kubernetes/**/*.yaml,**/kubernetes/**/*.yml,**/manifests/**/*.yaml,**/manifests/**/*.yml,**/helm/**/*.yaml,**/helm/**/*.yml,**/charts/**/*.yaml,**/charts/**/*.yml"
---

# Kubernetes Manifest Standards

## Scope

- Apply these rules when creating, reviewing, or changing Kubernetes resource manifests or Helm chart templates and values.
- This repository is primarily a personal macOS/Linux dotfiles project, not a Kubernetes application repository. Do not introduce cluster manifests, charts, or deployment tooling unless the user requests them.
- The `ai/` module installs repository-managed instructions from `ai/instructions/`; keep this file consistent with the frontmatter and naming conventions used by neighboring instruction files.
- `kubectl` and `helm` are optional work-environment tools here, not guaranteed dependencies. Do not assume cluster access or install new tooling without approval.
- If a YAML file's Kubernetes purpose is unclear, inspect its context before applying these rules; do not treat Compose files, CI workflows, or unrelated YAML as Kubernetes resources.

## Required workflow

### 1. Understand the deployment context

- Locate all relevant manifests, chart templates, values files, overlays, kustomizations, and referenced configuration before editing.
- Identify the target Kubernetes version, namespace, deployment environment, workload type, and existing conventions from project evidence.
- Check API versions and fields against the declared target version. Do not silently migrate API versions or change compatibility assumptions.
- When the required image, port, health endpoint, storage behavior, permissions, or resource sizing cannot be established, ask rather than inventing values.
- Preserve user changes and keep edits limited to the requested workload and its necessary references.

### 2. Author declarative, maintainable resources

- Keep desired state in version-controlled manifests, Kustomize overlays, or Helm chart sources; do not recommend imperative production changes as the source of truth.
- Make environment-specific differences explicit through overlays or chart values rather than copying and drifting whole manifests.
- Keep templates deterministic and review rendered output. Avoid runtime mutation of deployed images or resources; use immutable image references, preferably digests when the workflow supports them.
- Pin image versions instead of using floating tags such as `latest`. Derive compatible versions from project evidence or ask before changing them.
- Avoid embedding credentials, private keys, or other secret values in manifests, chart values, examples, logs, or diffs. Use the repository's established external secret-management mechanism; if none exists, ask which mechanism to use.
- Never commit plaintext secrets or weaken TLS verification to make a deployment work.

### 3. Specify workload resources and health

- Set meaningful CPU and memory requests and limits for every container in each pod specification, including application containers, sidecars, and init containers. Do not rely on namespace defaults as an undocumented substitute.
- Base resource values on measured usage, known workload requirements, or explicit operator input. If safe values are unknown, explain the gap and ask rather than guessing.
- Check that container-level values and their pod-level aggregate are appropriate for scheduling and cluster policy; account for the different scheduling and runtime effects of requests and limits.
- Configure startup, readiness, and liveness probes for long-running application containers when the application exposes a reliable way to check them. Derive probe type, path, port, command, and timing from the application contract.
- Use a startup probe to allow slow initialization without premature restarts. Readiness should represent whether the container can serve its intended traffic; liveness should detect a process that cannot recover on its own.
- Tune probe delays, periods, timeouts, and failure thresholds to expected startup and response behavior. Do not make liveness depend on a remote service whose outage should not restart every replica.
- Do not add meaningless probes to one-shot Jobs or other finite tasks. Where a probe is not applicable or the application provides no safe check, explain the limitation instead of fabricating one.

### 4. Apply least privilege and isolate workloads

- Run containers as a non-root user. Set `runAsNonRoot` and an explicit nonzero `runAsUser` when the image supports it.
- Set `allowPrivilegeEscalation: false`, `readOnlyRootFilesystem: true`, and drop all Linux capabilities by default. Add only individually justified capabilities or writable mounts required by the application.
- Use a `RuntimeDefault` seccomp profile where supported. Set compatible pod- and container-level security contexts without weakening either scope.
- Do not use privileged containers, host namespaces, host paths, or broad Linux capabilities unless the user confirms a documented requirement and the exception is narrowly scoped.
- Disable service-account token automounting when the workload does not call the Kubernetes API. If API access is necessary, use a dedicated service account and narrowly scoped RBAC.
- Place workloads in an explicitly selected, non-default namespace. Keep environment or tenant boundaries separate where the deployment design requires it; do not create or repurpose namespaces silently.
- Use NetworkPolicies to restrict ingress and egress when the cluster supports them and the required traffic is known. Avoid opening ports or granting cross-namespace access without justification.

### 5. Keep metadata and operations consistent

- Add stable, meaningful labels to supported resources, using Kubernetes recommended `app.kubernetes.io/*` labels where applicable. Keep selector labels consistent and immutable for the lifetime of a workload selector.
- Use annotations for operational metadata that does not belong in selectors or labels. Never put secret values in labels or annotations.
- Keep pod-template labels aligned with the owning workload's selectors and service selectors. Avoid changing selectors as incidental cleanup.
- Use explicit, compatible API versions and stable resource names. Include the namespace consistently for namespaced resources.
- Configure storage, rollout, disruption, and replica behavior only when supported by the application requirements and cluster context. Explain availability or data-retention consequences before changing them.

### 6. Validate safely

- Review both the source and the complete rendered manifests after changing overlays or Helm templates; check that templating has not omitted required resources or introduced unsafe defaults.
- Use available, existing validation commands appropriate to the files: `helm lint` and `helm template` for charts, and `kubectl apply --dry-run=client` or a server-side dry run for raw manifests when the required context is available.
- Treat server-side validation as dependent on cluster access and target-version compatibility. Report checks that could not be run; do not imply validation succeeded when it did not.
- Do not apply, upgrade, delete, or otherwise change live cluster state without explicit user approval. Dry runs and diffs do not authorize deployment.
- Review changes for accidental secret exposure, excessive privileges, missing container resources or probes, selector drift, unintended public access, and destructive storage changes.

## Expected output

Summarize the files and workload reviewed, assumptions that were confirmed or require user input, changes made, security and operational impact, validation commands and results, and any checks unavailable due to missing tools or cluster access.

## Completion checklist

- Target cluster version, workload intent, namespace, and relevant chart or overlay context were established or reported as unknown.
- Each pod container has evidence-based CPU/memory requests and limits, and long-running containers have appropriate startup, readiness, and liveness checks.
- Workloads use least-privilege security settings, appropriate metadata, and deliberate namespace and network boundaries.
- Desired state remains declarative and image references are immutable or appropriately pinned.
- Rendered configuration and available validations were reviewed; live changes were not performed without explicit approval.
