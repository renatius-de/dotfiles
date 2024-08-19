ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.ssh
SSH_CONFIG = $(DIRECTORY)/config

$(DIRECTORY):
	mkdir -m 0700 $(DIRECTORY)

$(DIRECTORY)/keys:
	mkdir -m 0700 $(DIRECTORY)/keys

$(HOME)/.ssh/config.local: | $(DIRECTORY)
	touch $(SSH_CONFIG).local

$(SSH_CONFIG): | $(DIRECTORY) $(HOME)/.ssh/config.local
	ln -snf $(ROOT_DIR)/config $(SSH_CONFIG)

.PHONY: clean
clean:
	rm -f $(SSH_CONFIG)

.PHONY: install
install: | $(SSH_CONFIG)

.PHONY: upgrade
upgrade: | install
