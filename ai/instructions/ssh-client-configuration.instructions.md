---
name: ssh-client-configuration
description: "Use when changing this repository's OpenSSH client configuration or its local override contract."
applyTo: "ssh/config"
---

# OpenSSH Client Configuration Standards

## Scope

Apply to tracked `ssh/config` and its `~/.ssh/config.local` contract. Preserve shared/local separation; the local override may contain private host details and is not a source for tracked secrets. For SSH installation targets, also follow repository Makefile standards.

## Required behavior

- Check directive spelling, supported OpenSSH versions, and scope before editing; preserve `Host`, `Match`, and `Include` ordering and effects.
- Preserve secure host-key verification and public-key authentication defaults. Explain any proposed weakening or change to authentication, forwarding, or host-key policy and obtain approval before applying it.
- Keep private keys, credentials, personal hostnames, and machine-specific settings out of tracked files. Put host-specific values in the existing local override and do not read or reproduce sensitive local values in reports.
- Keep settings minimal and specific to the intended hosts. Do not add broad forwarding, wildcard trust, or password-based authentication without an explicit requirement.
- Parse configuration only; never connect to a remote host for syntax validation.

## Do not

- Do not add private key material, tokens, passwords, or sensitive host details to the repository.
- Do not disable host-key checking or weaken host-key verification to work around connectivity problems.
- Do not alter permissions or contents under `~/.ssh/keys/` as part of a configuration-only change.
- Do not assume that a missing optional local override should be created or populated.

## Verification

- Use OpenSSH's effective-configuration mode to parse the intended file without making a connection:

  ```bash
  ssh -G -F ssh/config github.com
  ```

- Account for `Include` resolution when validating a local override. If required includes or the OpenSSH client are unavailable, report the exact limitation rather than claiming validation succeeded.
- Review the effective settings for the intended host pattern and confirm that authentication and host-key verification remain as designed.

## Success criteria

- The shared and local configuration boundary is preserved, secure defaults remain explicit, and the updated configuration parses without contacting a remote host.
