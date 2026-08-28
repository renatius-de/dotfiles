include ../make/common.mk

SUDO := sudo
BREW_NVM_PREFIX := $(shell if [ -n "$(BREW)" ]; then "$(BREW)" --prefix nvm 2>/dev/null; fi)
JENV := jenv
KEYTOOL := keytool

STORE_PASS ?= changeit
CERT_FILE := $(HOME)/dev/optadata-gruppe-ODA-DC1-CA.cer
CERT_ALIAS := opta_data-gruppe-certificate

JAVA_HOME_BASE := /Library/Java/JavaVirtualMachines
CORRETTO_VERSIONS := 25
CORRETTO_CASK_PREFIX := corretto@
WORK_ENV ?= false

CASK_NAME_OF = $(CORRETTO_CASK_PREFIX)$(1)
JDK_HOME_OF = $(JAVA_HOME_BASE)/amazon-corretto-$(1).jdk
JDK_CONTENTS_HOME_OF = $(call JDK_HOME_OF,$(1))/Contents/Home
JDK_BIN_OF = $(call JDK_CONTENTS_HOME_OF,$(1))/bin
KEYTOOL_BIN_OF = $(call JDK_BIN_OF,$(1))/$(KEYTOOL)

KEYTOOL_CA_CERTS_ARGS := -import -trustcacerts -alias "$(CERT_ALIAS)" \
  -file "$(CERT_FILE)" -cacerts -storepass "$(STORE_PASS)" -noprompt

NVM_DIR := $(HOME)/.nvm
NODE_LTS_VERSIONS := 24

define install_java_for_version
	JDK_DIR="$(call JDK_HOME_OF,$(1))"; \
	if [ ! -d "$$JDK_DIR" ]; then \
	  $(BREW) install --cask "$(call CASK_NAME_OF,$(1))"; \
	fi; \
	if [ -d "$$JDK_DIR" ]; then \
	  $(JENV) add "$(call JDK_CONTENTS_HOME_OF,$(1))" > /dev/null || true; \
	  $(JENV) global "$(1)" > /dev/null || true; \
	else \
	  printf "Warning: JDK directory '%s' not found after install, skipping jenv add\n" "$$JDK_DIR"; \
	fi
endef

define uninstall_java_for_version
	JDK_DIR="$(call JDK_HOME_OF,$(1))"; \
	if [ -d "$$JDK_DIR" ]; then \
	  $(BREW) uninstall --ignore-dependencies --force "$(call CASK_NAME_OF,$(1))"; \
	else \
	  printf "Warning: JDK directory '%s' not found, skipping uninstall\n" "$$JDK_DIR"; \
	fi
endef

define import_ca_certs_for_version
	if [ -r "$(CERT_FILE)" ]; then \
	  KEYTOOL_BIN="$(call KEYTOOL_BIN_OF,$(1))"; \
	  if [ -x "$$KEYTOOL_BIN" ]; then \
	    if ! $(SUDO) "$$KEYTOOL_BIN" -list -cacerts \
	        -storepass "$(STORE_PASS)" -alias "$(CERT_ALIAS)" >/dev/null; then \
	      $(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_ARGS) \
	        || printf "Warning: cert import failed for %s\n" "$$KEYTOOL_BIN"; \
	    fi; \
		else \
	    printf "Warning: keytool binary '%s' not found or not executable\n" "$$KEYTOOL_BIN"; \
	  fi; \
	else \
	  printf "Warning: cert file '%s' not found or not readable\n" "$(CERT_FILE)"; \
	fi
endef

define for_each_corretto_version
	@for v in $(CORRETTO_VERSIONS); do $(call $(1),$$v); done
endef

define update_nodejs_with_nvm
	@for v in $(NODE_LTS_VERSIONS); do \
		if [ -n "$(BREW_NVM_PREFIX)" ] && [ -s "$(BREW_NVM_PREFIX)/nvm.sh" ]; then \
			. "$(BREW_NVM_PREFIX)/nvm.sh" >/dev/null; \
			nvm install --lts --latest-npm --no-progress --default "$(v)" >/dev/null; \
			nvm alias default "$(v)" >/dev/null; \
		else \
			printf "Warning: nvm not found or not installed via Homebrew, skipping Node.js update\n"; \
		fi; \
	done
endef

.PHONY: ensure-prereqs import-ca-certs install-java install-nodejs update-nodejs uninstall-java install upgrade clean

ensure-prereqs:
	@$(call ensure_brew)
	@$(call ensure_cmd,$(JENV))
	@$(call ensure_cmd,$(SUDO))

install-java: ensure-prereqs
ifeq ($(WORK_ENV),true)
	@$(call for_each_corretto_version,install_java_for_version)
endif

update-nodejs:
	@$(call update_nodejs_with_nvm)

install-nodejs: update-nodejs

import-ca-certs: install-java
ifeq ($(WORK_ENV),true)
	@$(call for_each_corretto_version,import_ca_certs_for_version)
endif

uninstall-java:
	@$(call for_each_corretto_version,uninstall_java_for_version)

install: install-java import-ca-certs install-nodejs

upgrade: install

clean: uninstall-java
	$(RM_RF) "$(NVM_DIR)"
