ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -f ${HOME}/.calendar

install:
	ln -snf ${ROOT_DIR}/calendar ${HOME}/.calendar
