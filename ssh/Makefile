.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.ssh
SSH_CONFIG = $(DIRECTORY)/config
SSH_CONFIG_LOCAL = $(DIRECTORY)/config.local

$(DIRECTORY):
	mkdir -m 0700 $(DIRECTORY)

$(DIRECTORY)/keys: | $(DIRECTORY)
	mkdir -m 0700 $(DIRECTORY)/keys

$(SSH_CONFIG_LOCAL): | $(DIRECTORY)/keys
	touch $(SSH_CONFIG).local

$(SSH_CONFIG): | $(DIRECTORY)
	ln -snf $(ROOT_DIR)/config $(SSH_CONFIG)

.PHONY: install
install: | $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)

.PHONY: upgrade
upgrade: | install

.PHONY: clean
clean:
	rm -f $(SSH_CONFIG)
