.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
SHELL := /bin/bash

SUDO    := sudo
BREW    := $(shell command -v brew 2>/dev/null || command -v /opt/homebrew/bin/brew 2>/dev/null || command -v /usr/local/bin/brew 2>/dev/null || printf brew)
JENV    := jenv
KEYTOOL := keytool

STORE_PASS ?= changeit
CERT_FILE  := $(HOME)/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer
CERT_ALIAS := opta_data-gruppe-certificate

JAVA_HOME_BASE        := /Library/Java/JavaVirtualMachines
CORRETTO_VERSIONS     := 25 21
CORRETTO_CASK_PREFIX  := corretto@

CASK_NAME_OF         = $(CORRETTO_CASK_PREFIX)$(1)
JDK_HOME_OF          = $(JAVA_HOME_BASE)/amazon-corretto-$(1).jdk
JDK_CONTENTS_HOME_OF = $(call JDK_HOME_OF,$(1))/Contents/Home
JDK_BIN_OF           = $(call JDK_CONTENTS_HOME_OF,$(1))/bin
KEYTOOL_BIN_OF       = $(call JDK_BIN_OF,$(1))/$(KEYTOOL)

KEYTOOL_CA_CERTS_ARGS := -import -trustcacerts -alias "$(CERT_ALIAS)" -file "$(CERT_FILE)" -cacerts -storepass "$(STORE_PASS)" -noprompt

define ensure_cmd
	@command -v $(1) >/dev/null 2>&1 || { echo "Fehler: Befehl '$(1)' nicht gefunden."; exit 1; }
endef

define for_each_corretto_version
	@for v in $(CORRETTO_VERSIONS); do \
		$(1); \
	done
endef

define import_ca_certs_for_version
	if [ -r "$(CERT_FILE)" ]; then \
		KEYTOOL_BIN="$(call KEYTOOL_BIN_OF,$(1))"; \
		if [ -x "$$KEYTOOL_BIN" ]; then \
			$(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_ARGS) || { echo "Warnung: Zertifikatsimport für $$KEYTOOL_BIN fehlgeschlagen"; }; \
		fi \
	fi
endef

define install_java_for_version
	JDK_DIR="$(call JDK_HOME_OF,$(1))"; \
	if [ ! -d "$$JDK_DIR" ]; then \
		$(BREW) install --cask "$(call CASK_NAME_OF,$(1))"; \
	fi; \
	if [ -d "$$JDK_DIR" ]; then \
		$(JENV) add "$(call JDK_CONTENTS_HOME_OF,$(1))" || true; \
		$(JENV) global "$(1)" || true; \
	fi
endef

define uninstall_java_for_version
	JDK_DIR="$(call JDK_HOME_OF,$(1))"; \
	if [ -d "$$JDK_DIR" ]; then \
		$(BREW) uninstall --ignore-dependencies --force "$(call CASK_NAME_OF,$(1))"; \
	fi
endef

.PHONY: ensure-prereqs import-ca-certs install-java uninstall-java install upgrade clean

ensure-prereqs:
	$(call ensure_cmd,$(BREW))
	$(call ensure_cmd,$(JENV))

import-ca-certs: | install-java
	$(call for_each_corretto_version, \
		$(call import_ca_certs_for_version,$${v}) \
	)

install-java: | ensure-prereqs
	$(call for_each_corretto_version, \
		$(call install_java_for_version,$${v}) \
	)

uninstall-java:
	$(call for_each_corretto_version, \
		$(call uninstall_java_for_version,$${v}) \
	)

install: install-java import-ca-certs

upgrade: install-java import-ca-certs

clean: | uninstall-java
