ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.tmuxinator

$(DIRECTORY):
	ln -snf $(ROOT_DIR)/tmuxinator $(DIRECTORY)

.PHONY: clean
clean:
	rm -f $(DIRECTORY)

.PHONY: install
install: | $(DIRECTORY)
