ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/.cddb

.PHONY: install
install:
	ln -snf ${ROOT_DIR} ${HOME}/.cddb

.PHONY: default
default: | clean install
