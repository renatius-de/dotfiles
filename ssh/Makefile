.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

SSH_DIR            := $(HOME)/.ssh
SSH_CONFIG         := $(SSH_DIR)/config
SSH_CONFIG_LOCAL   := $(SSH_DIR)/config.local
KEYS_DIR           := $(SSH_DIR)/keys

$(SSH_DIR):
	install -d -m 0700 $@

$(KEYS_DIR): | $(SSH_DIR)
	install -d -m 0700 $@

$(SSH_CONFIG_LOCAL): | $(KEYS_DIR)
	touch $@

$(SSH_CONFIG): | $(SSH_DIR)
	ln -snf $(ROOT_DIR)/config $@

.PHONY: install upgrade
install: | $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)
upgrade: | install

.PHONY: clean
clean:
	rm -f $(SSH_CONFIG)
