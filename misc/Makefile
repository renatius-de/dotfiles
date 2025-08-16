.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

SHELL := /bin/bash

SUDO              := sudo
BREW              := brew
JENV              := jenv

STORE_PASS        := changeit
CERT_FILE         := $(HOME)/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer
JAVA_HOME_BASE    := /Library/Java/JavaVirtualMachines
CORRETTO_VERSIONS := 21
CERT_ALIAS        := opta_data-gruppe-certificate
KEYTOOL           := keytool

JDK_HOME = $(JAVA_HOME_BASE)/amazon-corretto-$(1).jdk
JDK_BIN  = $(call JDK_HOME,$(1))/Contents/Home/bin

KEYTOOL_CA_CERTS_CMD = -import -trustcacerts -alias "$(CERT_ALIAS)" -file "$(CERT_FILE)" -cacerts -storepass "$(STORE_PASS)" -noprompt

define do_import_ca_certs
	@for v in $(CORRETTO_VERSIONS); do \
		KEYTOOL_BIN="$(call JDK_BIN,$${v})/$(KEYTOOL)"; \
		if [ -x "$$KEYTOOL_BIN" ]; then \
			$(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_CMD) || true; \
		fi; \
	done
endef

.PHONY: import-ca-certs install-java install upgrade clean

import-ca-certs:
	@if [ ! -r "$(CERT_FILE)" ]; then \
		echo "Fehler: Zertifikatsdatei nicht gefunden: $(CERT_FILE)"; \
		exit 0; \
	fi
	$(do_import_ca_certs)

install-java:
	@for v in $(CORRETTO_VERSIONS); do \
		JDK_DIR="$(call JDK_HOME,$${v})"; \
		if [ ! -d "$$JDK_DIR" ]; then \
			$(BREW) install --cask "corretto@$${v}"; \
			$(JENV) add "$$JDK_DIR/Contents/Home" || true; \
			$(JENV) global "$${v}" || true; \
		fi; \
	done

install: install-java import-ca-certs
upgrade: import-ca-certs

clean:
	-rm -rf -- "$(HOME)/.tool-versions"
	-rm -rf -- "$(ASDF_CONFIG)"
	-rm -rf -- "$(HOME)/.asdf"
	-rm -rf -- "$(HOME)/.config/cheat"
	-rm -rf -- "$(HOME)/.sdkman"
	-rm -rf -- "$(HOME)/.nvm"
	-rm -rf -- "$(HOME)/.npm"
