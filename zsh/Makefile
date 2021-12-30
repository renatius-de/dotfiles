ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ANTIGEN = ${PLUGIN_DIRECTORY}/antigen.zsh
FZF = ${PLUGIN_DIRECTORY}/fzf
PLUGIN_DIRECTORY = $(ROOT_DIR)/plugin
SDKMAN = ${HOME}/.sdkman
SHARE = ${HOME}/.cache/zsh

.PHONY: clean
clean:
	rm -f ${HOME}/.cache/zsh/history
	rm -f ${HOME}/.fzf.zsh
	rm -f ${HOME}/.zcompdump
	rm -f ${HOME}/.zlogout
	rm -f ${HOME}/.zprofile
	rm -f ${HOME}/.zsh
	rm -f ${HOME}/.zshenv
	rm -f ${HOME}/.zshrc
	rm -fr ${HOME}/.antigen
	rm -rf ${HOME}/.nvm
	rm -rf ${HOME}/.sdkman
	#
	rm -fr $(PLUGIN_DIRECTORY)
	#
	rm -fr $(SHARE)
	#
	find ${HOME} -name '*.zwc' -delete

.PHONY: install
install: | plugin
	mkdir -p $(SHARE)
	#
	ln -snf ${ROOT_DIR}/zlogout ${HOME}/.zlogout
	ln -snf ${ROOT_DIR}/zprofile ${HOME}/.zprofile
	ln -snf ${ROOT_DIR}/zshenv ${HOME}/.zshenv
	ln -snf ${ROOT_DIR}/zshrc ${HOME}/.zshrc

plugin: | antigen ${SDKMAN}

antigen: | ${HOME}/.zsh ${ANTIGEN}

${HOME}/.zsh:
	ln -snf $(ROOT_DIR) ${HOME}/.zsh

${ANTIGEN}:
	mkdir -p ${PLUGIN_DIRECTORY}
	#
	curl --silent --location git.io/antigen --output ${ANTIGEN}

${SDKMAN}:
	curl --silent 'https://get.sdkman.io?rcupdate=false' | bash

.PHONY: default
default: | clean install
