ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/.calendar

.PHONY: install
install:
	ln -snf ${ROOT_DIR}/calendar ${HOME}/.calendar

.PHONY: default
default: | clean install
