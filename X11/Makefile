ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ABCDE_CONF = $(HOME)/.abcde.conf
ASPELL_CONF = $(HOME)/.aspell.conf

$(ABCDE_CONF):
	ln -snf $(ROOT_DIR)/abcde.conf $(ABCDE_CONF)

$(ASPELL_CONF):
	ln -snf $(ROOT_DIR)/aspell.conf $(ASPELL_CONF)

.PHONY: clean
clean:
	rm -f $(ABCDE_CONF)
	rm -f $(ASPELL_CONF)

.PHONY: install
install: | $(ABCDE_CONF) $(ASPELL_CONF)
