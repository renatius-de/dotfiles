.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: install
install:
ifeq (,$(wildcard $(HOME)/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer))
	keytool -import -trustcacerts -alias od-cert -file ~/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer -cacerts -storepass changeit -noprompt
endif

.PHONY: upgrade
upgrade:

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
