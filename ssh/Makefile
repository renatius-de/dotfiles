ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.ssh
SSH_CONFIG = $(DIRECTORY)/config

$(DIRECTORY):
	mkdir -m 0700 $(DIRECTORY)

$(SSH_CONFIG): | $(DIRECTORY)
	ln -snf $(ROOT_DIR)/config $(SSH_CONFIG)

.PHONY: clean
clean:
	rm -f $(SSH_CONFIG)

.PHONY: install
install: | $(SSH_CONFIG)

.PHONY: upgrade
upgrade: | install
