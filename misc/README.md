# Utility and Java Setup

This module handles environment support tasks such as Java installation, certificate import, and Node.js setup through the local toolchain.

## Installation

```bash
make -C misc install
```

To enable the work environment setup that installs Java and related tooling:

```bash
WORK_ENV=true make -C misc install
```

## Key Targets

- `install` — installs Java tooling, imports CA certificates, and updates Node.js when relevant
- `upgrade` — runs the same setup flow again
- `clean` — removes installed Java tooling and uninstalls generated runtime state
- `ensure-prereqs` — validates required tools are available
- `install-java` — installs the configured Corretto versions
- `import-ca-certs` — imports the configured CA certificate into Java keystores
- `install-nodejs` — ensures Node.js is available through `nvm`

## Configuration Variables

The module supports a few environment variables:

- `WORK_ENV` — enables work-environment tools and Java installs
- `STORE_PASS` — Java keystore password, default `changeit`
- `CERT_FILE` — path to the organization CA certificate
- `CORRETTO_VERSIONS` — versions to install when the work environment is enabled

## Java Workflow

When `WORK_ENV=true`, the setup does the following:

1. verifies Homebrew and required CLI tools
2. installs the configured Amazon Corretto JDKs
3. registers them with `jenv`
4. imports the configured CA certificate into the Java trust store
5. ensures the Node.js toolchain is available via `nvm`

## Prerequisites

- Homebrew
- `jenv` for Java version management
- `sudo` access for certificate import operations

## Customization

Adjust the behavior by editing the `Makefile` values for:

- `CORRETTO_VERSIONS`
- `CERT_FILE`
- `WORK_ENV`

Then rerun:

```bash
WORK_ENV=true make -C misc install
```
