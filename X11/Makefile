ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/.abcde.conf
	rm -f ${HOME}/.aspell.conf
	rm -f ${HOME}/.config/gtk-3.0/bookmarks
	rm -f ${HOME}/.gtk-bookmarks
	rm -f ${HOME}/.gtkrc-2.0
	rm -f ${HOME}/.Xdefaults
	rm -f ${HOME}/.Xmodmap

.PHONY: install
install:
	mkdir -p ${HOME}/.config/gtk-3.0
	ln -snf ${ROOT_DIR}/abcde.conf ${HOME}/.abcde.conf
	ln -snf ${ROOT_DIR}/aspell.conf ${HOME}/.aspell.conf
	ln -snf ${ROOT_DIR}/gtk-bookmarks ${HOME}/.config/gtk-3.0/bookmarks

.PHONY: default
default: | clean install
