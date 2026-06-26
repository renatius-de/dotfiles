include ../make/common.mk

SUDO := sudo
BREW := $(shell command -v brew 2>/dev/null \
  || command -v /opt/homebrew/bin/brew 2>/dev/null \
  || command -v /usr/local/bin/brew 2>/dev/null \
  || echo)
JENV := jenv
KEYTOOL := keytool

STORE_PASS ?= changeit
CERT_FILE := $(HOME)/dev/opta\ data/optadata-gruppe-ODA-DC1-CA.cer
CERT_ALIAS := opta_data-gruppe-certificate

JAVA_HOME_BASE := /Library/Java/JavaVirtualMachines
CORRETTO_VERSIONS := 21 25
CORRETTO_CASK_PREFIX := corretto@
WORK_ENV ?= false

CASK_NAME_OF = $(CORRETTO_CASK_PREFIX)$(1)
JDK_HOME_OF = $(JAVA_HOME_BASE)/amazon-corretto-$(1).jdk
JDK_CONTENTS_HOME_OF = $(call JDK_HOME_OF,$(1))/Contents/Home
JDK_BIN_OF = $(call JDK_CONTENTS_HOME_OF,$(1))/bin
KEYTOOL_BIN_OF = $(call JDK_BIN_OF,$(1))/$(KEYTOOL)

KEYTOOL_CA_CERTS_ARGS := -import -trustcacerts -alias "$(CERT_ALIAS)" \
  -file "$(CERT_FILE)" -cacerts -storepass "$(STORE_PASS)" -noprompt

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

define import_ca_certs_for_version
	if [ -r "$(CERT_FILE)" ]; then \
	  KEYTOOL_BIN="$(call KEYTOOL_BIN_OF,$(1))"; \
	  if [ -x "$$KEYTOOL_BIN" ]; then \
	    if ! $(SUDO) "$$KEYTOOL_BIN" -list -cacerts \
	        -storepass "$(STORE_PASS)" -alias "$(CERT_ALIAS)" >/dev/null 2>&1; then \
	      $(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_ARGS) \
	        || printf "Warning: cert import failed for %s\n" "$$KEYTOOL_BIN"; \
	    else \
	      printf "Certificate %s already installed in %s\n" "$(CERT_ALIAS)" "$$KEYTOOL_BIN"; \
	    fi; \
	  fi; \
	fi
endef

define for_each_corretto_version
	@for v in $(CORRETTO_VERSIONS); do $(call $(1),$$v); done
endef

.PHONY: ensure-prereqs import-ca-certs install-java uninstall-java install upgrade clean

ensure-prereqs:
	@$(call ensure_cmd,$(BREW))
	@$(call ensure_cmd,$(JENV))
	@$(call ensure_cmd,$(SUDO))

install-java: ensure-prereqs
ifeq ($(WORK_ENV),true)
	@$(call for_each_corretto_version,install_java_for_version)
else
	@printf "Skipping Corretto installation because WORK_ENV=%s\n" "$(WORK_ENV)"
endif

import-ca-certs: install-java
ifeq ($(WORK_ENV),true)
	@$(call for_each_corretto_version,import_ca_certs_for_version)
else
	@printf "Skipping CA cert import because WORK_ENV=%s\n" "$(WORK_ENV)"
endif

uninstall-java:
	@$(call for_each_corretto_version,uninstall_java_for_version)

install: install-java import-ca-certs

upgrade: install

clean: uninstall-java
