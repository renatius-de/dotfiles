.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

SUDO               := sudo
STORE_PASS         := changeit
CERT_FILE          := $(HOME)/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer
JAVA_HOME_BASE     := /Library/Java/JavaVirtualMachines
CORRETTO_VERSIONS  := 24 21 17
CERT_ALIAS         := opta_data-gruppe-certificate
KEYTOOL            := keytool

KEYTOOL_CA_CERTS_CMD := -import -trustcacerts -alias "$(CERT_ALIAS)" -file "$(CERT_FILE)" -cacerts -storepass $(STORE_PASS) -noprompt

define import_ca_certs
	@for v in $(CORRETTO_VERSIONS); do \
		KEYTOOL_BIN="$(JAVA_HOME_BASE)/amazon-corretto-$${v}.jdk/Contents/Home/bin/$(KEYTOOL)"; \
		if [ -x "$$KEYTOOL_BIN" ]; then \
			echo "Importiere Zertifikat in Corretto $${v} (cacerts)…"; \
			$(SUDO) "$$KEYTOOL_BIN" $(KEYTOOL_CA_CERTS_CMD) || true; \
		else \
			echo "Überspringe Corretto $${v}: keytool nicht gefunden unter $$KEYTOOL_BIN"; \
		fi; \
	done
endef

.PHONY: \
	import-ca-certs \
	import-ca-certs \
	install \
	upgrade

import-ca-certs:
	@if [ ! -r "$(CERT_FILE)" ]; then \
		echo "Fehler: Zertifikatsdatei nicht gefunden: $(CERT_FILE)"; \
		exit 1; \
	fi
	$(import_ca_certs)

import-ca-certs: import-ca-certs

install: import-ca-certs
upgrade: import-ca-certs

.PHONY: clean
clean:
	rm -fr $(HOME)/.tool-versions
	#
	rm -fr $(ASDF_CONFIG)
	rm -fr $(HOME)/.asdf
	#
	rm -fr $(HOME)/.config/cheat
	#
	rm -fr $(HOME)/.sdkman
	#
	rm -rf $(HOME)/.nvm
	rm -rf $(HOME)/.npm
