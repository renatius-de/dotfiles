# Utility and Java setup

This module manages local environment setup tasks such as Java installation, CA trust import, and Node.js bootstrapping when needed for the current machine.

## Installation

Run the default setup:

```bash
make -C misc install
```

Enable the work-oriented Java and certificate workflow:

```bash
WORK_ENV=true make -C misc install
```

## Key targets

- `install` — runs prerequisite checks, Java installation, certificate import, and Node.js setup
- `upgrade` — reruns the install flow
- `clean` — uninstalls Java toolchains and removes the local `~/.nvm` setup
- `ensure-prereqs` — validates required tooling is available
- `install-java` — installs the configured Amazon Corretto JDK versions when `WORK_ENV=true`
- `import-ca-certs` — imports the configured certificate into Java trust stores
- `install-nodejs` — ensures a Node.js LTS version is available via `nvm`

## Configuration variables

The module accepts the following variables:

- `WORK_ENV` — enables the Java and work environment package flow; default is `false`
- `STORE_PASS` — Java trust store password; default `changeit`
- `CERT_FILE` — path to the CA certificate to import
- `CORRETTO_VERSIONS` — JDK versions to install when work mode is enabled

## Work flow

When `WORK_ENV=true`, the setup does the following:

1. verifies Homebrew and required commands are present
2. installs the configured Amazon Corretto JDKs
3. registers them with `jenv`
4. imports the configured CA certificate into the Java trust store
5. ensures Node.js via `nvm` is installed for the selected LTS version

## Prerequisites

- Homebrew
- `jenv` for Java version management
- `sudo` access for certificate import operations

## Customization

Adjust the behavior by editing the values in the `Makefile` for:

- `CORRETTO_VERSIONS`
- `CERT_FILE`
- `WORK_ENV`

Then rerun:

```bash
WORK_ENV=true make -C misc install
```
