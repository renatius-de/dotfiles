ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -f ${HOME}/.cddb

install:
	ln -snf ${ROOT_DIR} ${HOME}/.cddb
