ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/.abcde.conf
	rm -f ${HOME}/.aspell.conf

.PHONY: install
install:
	ln -snf ${ROOT_DIR}/abcde.conf ${HOME}/.abcde.conf
	ln -snf ${ROOT_DIR}/aspell.conf ${HOME}/.aspell.conf

.PHONY: default
default: | clean install
