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
	printf "==> Installing JDK %s\n" "$(1)"; \
	if [ ! -d "$$JDK_DIR" ]; then \
	  $(BREW) install --cask "$(call CASK_NAME_OF,$(1))" || { printf "ERROR: target [install-java] failed while installing JDK %s\n" "$(1)" >&2; exit 1; }; \
	fi; \
	if [ -d "$$JDK_DIR" ]; then \
	  $(JENV) add "$(call JDK_CONTENTS_HOME_OF,$(1))" > /dev/null || true; \
	  $(JENV) global "$(1)" > /dev/null || true; \
	else \
	  printf "WARNING: JDK directory '%s' not found after install, skipping jenv add\n" "$$JDK_DIR"; \
	fi
endef

define uninstall_java_for_version
	JDK_DIR="$(call JDK_HOME_OF,$(1))"; \
	printf "==> Removing JDK %s\n" "$(1)"; \
	if [ -d "$$JDK_DIR" ]; then \
	  $(BREW) uninstall --ignore-dependencies --force "$(call CASK_NAME_OF,$(1))" || { printf "ERROR: target [uninstall-java] failed while removing JDK %s\n" "$(1)" >&2; exit 1; }; \
	else \
	  printf "WARNING: JDK directory '%s' not found, skipping uninstall\n" "$$JDK_DIR"; \
	fi
endef

define import_ca_certs_for_version
	if [ -r "$(CERT_FILE)" ]; then \
	  KEYTOOL_BIN="$(call KEYTOOL_BIN_OF,$(1))"; \
	  printf "==> Importing CA certificates for JDK %s\n" "$(1)"; \
	  if [ -x "$$KEYTOOL_BIN" ]; then \
	    if ! $(SUDO) "$$KEYTOOL_BIN" -list -cacerts \
	        -storepass "$(STORE_PASS)" -alias "$(CERT_ALIAS)" >/dev/null; then \
	      $(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_ARGS) \
	        || { printf "ERROR: target [import-ca-certs] failed while importing certificates for %s\n" "$$KEYTOOL_BIN" >&2; exit 1; }; \
	    fi; \
		else \
	    printf "WARNING: keytool binary '%s' not found or not executable\n" "$$KEYTOOL_BIN"; \
	  fi; \
	else \
	  printf "WARNING: cert file '%s' not found or not readable\n" "$(CERT_FILE)"; \
	fi
endef

define for_each_corretto_version
	@for v in $(CORRETTO_VERSIONS); do $(call $(1),$$v); done
endef

define update_nodejs_with_nvm
	@for v in $(NODE_LTS_VERSIONS); do \
		printf "==> Updating Node.js LTS version %s\n" "$$v"; \
		if [ -n "$(BREW_NVM_PREFIX)" ] && [ -s "$(BREW_NVM_PREFIX)/nvm.sh" ]; then \
			. "$(BREW_NVM_PREFIX)/nvm.sh" >/dev/null; \
			nvm install --lts --latest-npm --no-progress --default "$$v" >/dev/null || { printf "ERROR: target [install-nodejs] failed while installing Node.js %s\n" "$$v" >&2; exit 1; }; \
			nvm alias default "$$v" >/dev/null || { printf "ERROR: target [install-nodejs] failed while setting default Node.js %s\n" "$$v" >&2; exit 1; }; \
		else \
			printf "WARNING: nvm not found or not installed via Homebrew, skipping Node.js update\n"; \
		fi; \
	done
endef

.PHONY: ensure-prereqs import-ca-certs install-java install-nodejs update-nodejs uninstall-java upgrade clean

ensure-prereqs:
	$(call target_start,ensure-prereqs)
ifeq ($(BREW_AVAILABLE),true)
	@$(call ensure_cmd,$(JENV),ensure-prereqs) || { $(call fail_target,ensure-prereqs); }
	@$(call ensure_cmd,$(SUDO),ensure-prereqs) || { $(call fail_target,ensure-prereqs); }
else
	@printf "INFO: target [ensure-prereqs] skipped because Homebrew is not installed.\n"
	@printf "BREW_SKIP: target [ensure-prereqs] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"
endif
	$(call target_end,ensure-prereqs)

install-java: ensure-prereqs
	$(call target_start,install-java)
ifeq ($(BREW_AVAILABLE),true)
ifeq ($(WORK_ENV),true)
	@$(call for_each_corretto_version,install_java_for_version)
endif
else
	@printf "INFO: target [install-java] skipped because Homebrew is not installed.\n"
	@printf "BREW_SKIP: target [install-java] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"
endif
	$(call target_end,install-java)

update-nodejs:
	$(call target_start,update-nodejs)
ifeq ($(BREW_AVAILABLE),true)
	@$(call update_nodejs_with_nvm)
else
	@printf "INFO: target [update-nodejs] skipped because Homebrew is not installed.\n"
	@printf "BREW_SKIP: target [update-nodejs] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"
endif
	$(call target_end,update-nodejs)

install-nodejs: update-nodejs
	$(call target_start,install-nodejs)
	$(call target_end,install-nodejs)

import-ca-certs: install-java
	$(call target_start,import-ca-certs)
ifeq ($(BREW_AVAILABLE),true)
ifeq ($(WORK_ENV),true)
	@$(call for_each_corretto_version,import_ca_certs_for_version)
endif
else
	@printf "INFO: target [import-ca-certs] skipped because Homebrew is not installed.\n"
	@printf "BREW_SKIP: target [import-ca-certs] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"
endif
	$(call target_end,import-ca-certs)

uninstall-java:
	$(call target_start,uninstall-java)
ifeq ($(BREW_AVAILABLE),true)
	@$(call for_each_corretto_version,uninstall_java_for_version)
else
	@printf "INFO: target [uninstall-java] skipped because Homebrew is not installed.\n"
	@printf "BREW_SKIP: target [uninstall-java] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"
endif
	$(call target_end,uninstall-java)

install: install-java import-ca-certs install-nodejs
	$(call target_start,install)
	$(call target_end,install)

upgrade: install
	$(call target_start,upgrade)
	$(call target_end,upgrade)

clean: uninstall-java
	$(call target_start,clean)
	@$(RM_RF) "$(NVM_DIR)" || { $(call fail_target,clean); }
	$(call target_end,clean)
