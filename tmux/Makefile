ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.tmux
TMUX_CONF = $(HOME)/.tmux.conf

$(DIRECTORY):
	ln -snf $(ROOT_DIR) $(DIRECTORY)

$(TMUX_CONF):
	ln -snf $(ROOT_DIR)/tmux.conf $(TMUX_CONF)

.PHONY: clean
clean:
	rm -f $(HOME)/.screenrc
	#
	rm -f $(DIRECTORY)
	rm -f $(TMUX_CONF)

.PHONY: install
install: | $(DIRECTORY) $(TMUX_CONF)
