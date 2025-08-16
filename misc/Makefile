.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

SUDO    := sudo
BREW    := brew
JENV    := jenv
KEYTOOL := keytool

STORE_PASS ?= changeit
CERT_FILE  := $(HOME)/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer
CERT_ALIAS := opta_data-gruppe-certificate

JAVA_HOME_BASE    := /Library/Java/JavaVirtualMachines
CORRETTO_VERSIONS := 21
BREW_CASK_PREFIX  := amazon-corretto@

JDK_HOME_OF          = $(JAVA_HOME_BASE)/amazon-corretto-$(1).jdk
JDK_CONTENTS_HOME_OF = $(call JDK_HOME_OF,$(1))/Contents/Home
JDK_BIN_OF           = $(call JDK_CONTENTS_HOME_OF,$(1))/bin
KEYTOOL_BIN_OF       = $(call JDK_BIN_OF,$(1))/$(KEYTOOL)

KEYTOOL_CA_CERTS_ARGS := -import -trustcacerts -alias "$(CERT_ALIAS)" -file "$(CERT_FILE)" -cacerts -storepass "$(STORE_PASS)" -noprompt

define for_each_corretto_version
	@for v in $(CORRETTO_VERSIONS); do \
		$(1); \
	done
endef

define import_ca_certs_for_version
	if [ -r "$(CERT_FILE)" ]; then \
		KEYTOOL_BIN="$(call KEYTOOL_BIN_OF,$(1))"; \
		if [ -x "$$KEYTOOL_BIN" ]; then \
			$(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_ARGS) || { echo "Warnung: Zertifikatsimport für $$KEYTOOL_BIN fehlgeschlagen"; exit 1; }; \
		fi \
	fi
endef

define install_java_for_version
	JDK_DIR="$(call JDK_HOME_OF,$(1))"; \
	if [ ! -d "$$JDK_DIR" ]; then \
		$(BREW) install --cask "$(BREW_CASK_PREFIX)$(1)"; \
		$(JENV) add "$(call JDK_CONTENTS_HOME_OF,$(1))" || true; \
		$(JENV) global "$(1)" || true; \
	fi
endef

.PHONY: import-ca-certs install-java install upgrade clean

import-ca-certs:
	$(call for_each_corretto_version, \
		$(call import_ca_certs_for_version,$${v}) \
	)

install-java:
	$(call for_each_corretto_version, \
		$(call install_java_for_version,$${v}) \
	)

install: install-java import-ca-certs

upgrade: install-java import-ca-certs

clean:
	- rm -rf -- "$(HOME)/.tool-versions" \
	          "$(HOME)/.asdf" \
	          "$(HOME)/.config/cheat" \
	          "$(HOME)/.sdkman" \
	          "$(HOME)/.nvm" \
	          "$(HOME)/.npm"
	- [ -n "$${ASDF_CONFIG-}" ] && rm -rf -- "$${ASDF_CONFIG}" || true
