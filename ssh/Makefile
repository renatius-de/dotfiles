.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR           := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SSH_DIR            := $(HOME)/.ssh
SSH_CONFIG         := $(SSH_DIR)/config
SSH_CONFIG_LOCAL   := $(SSH_DIR)/config.local
SSH_KEYS_DIR       := $(SSH_DIR)/keys

DIR_MODE           := 0700
FILE_MODE          := 0600
SSH_CONFIG_SOURCE  := $(ROOT_DIR)/config

.PHONY: install upgrade clean

$(SSH_DIR):
	install -d -m $(DIR_MODE) $@

$(SSH_KEYS_DIR): | $(SSH_DIR)
	install -d -m $(DIR_MODE) $@

$(SSH_CONFIG_LOCAL): | $(SSH_KEYS_DIR)
	@if [ ! -e "$@" ]; then install -m $(FILE_MODE) /dev/null "$@"; fi

$(SSH_CONFIG): | $(SSH_DIR)
	ln -snf $(SSH_CONFIG_SOURCE) $@

install: | $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)

upgrade: | install

clean:
	rm -f $(SSH_CONFIG)
