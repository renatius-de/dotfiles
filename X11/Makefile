ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ABCDE_CONF = $(HOME)/.abcde.conf

$(ABCDE_CONF):
	ln -snf $(ROOT_DIR)/abcde.conf $(ABCDE_CONF)

.PHONY: clean
clean:
	rm -f $(ABCDE_CONF)

.PHONY: install
install: | $(ABCDE_CONF)

.PHONY: upgrade
upgrade: | install
	#
