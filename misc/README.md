# Utility Scripts and Configuration

Utility scripts for environment setup, Java configuration, and system maintenance.

## Installation

Install all utility scripts and Java configuration:

```bash
make -C misc install
```

To enable work environment setup (Java, Maven, Gradle, Kubernetes tools), set:

```bash
WORK_ENV=true make -C misc install
```

## Important Targets

- `install` — Installs Java runtimes and imports CA certificates
- `upgrade` — Performs the same steps as `install`
- `clean` — Removes installed Java runtimes
- `ensure-prereqs` — Verifies required tools are available
- `install-java` — Installs Java distributions (when `WORK_ENV=true`)
- `import-ca-certs` — Imports certificates into Java keystores
- `uninstall-java` — Removes Java distributions

## Important Files

- `Makefile` — Installation and configuration targets

## Configuration

The `Makefile` supports several environment variables:

- `WORK_ENV` — Set to `true` to enable work environment packages (default: `false`)
- `STORE_PASS` — Java keystore password (default: `changeit`)
- `CERT_FILE` — Path to CA certificate file
- `CORRETTO_VERSIONS` — Java versions to install (default: `21 25`)

## Java Setup

When `WORK_ENV=true` and a certificate file is configured:

1. Installs Amazon Corretto JDKs (versions 21 and 25)
2. Registers JDKs with `jenv` (Java environment manager)
3. Imports organization CA certificates into Java keystores
4. Sets a default Java version

## Prerequisites

- Homebrew (for package management)
- `jenv` (for Java version management when `WORK_ENV=true`)
- `sudo` access (for certificate imports)

## Local Customization

To use custom Java versions or certificates:

1. Update `CORRETTO_VERSIONS` in the `Makefile`
2. Update `CERT_FILE` to point to your organization's CA certificate
3. Run `WORK_ENV=true make -C misc install`
