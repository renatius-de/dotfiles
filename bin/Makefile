ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/bin

$(DIRECTORY):
	ln -snf $(ROOT_DIR) $(DIRECTORY)

.PHONY: clean
clean:
	rm -f $(DIRECTORY)

.PHONY: install
install: | $(DIRECTORY)

.PHONY: upgrade
upgrade: | install
