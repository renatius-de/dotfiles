ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/.config

.PHONY: install
install:
	ln -snf ${ROOT_DIR} ${HOME}/.config

.PHONY: default
default: | install
