ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/bin

.PHONY: install
install:
	ln -snf ${ROOT_DIR} ${HOME}/bin

.PHONY: default
default: | clean install
