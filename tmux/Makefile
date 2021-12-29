ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

PLUGIN_DIRECTORY = plugins
TPM = ${PLUGIN_DIRECTORY}/tpm

.PHONY: clean
clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux
	rm -f ${HOME}/.tmux.conf
	rm -f ${HOME}/.tmuxinator
	rm -fr $(PLUGIN_DIRECTORY)

.PHONY: install
install: | ${HOME}/.tmux ${HOME}/.tmuxinator
	ln -snf ${ROOT_DIR}/tmux.conf ${HOME}/.tmux.conf

${HOME}/.tmux:
	ln -snf ${ROOT_DIR} ${HOME}/.tmux

${HOME}/.tmuxinator:
	ln -snf ${ROOT_DIR}/tmuxinator ${HOME}/.tmuxinator

.PHONY: default
default: | clean install
