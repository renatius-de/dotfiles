ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ANTIGEN          = ${PLUGIN_DIRECTORY}/antigen.zsh
FZF              = ${PLUGIN_DIRECTORY}/fzf
PLUGIN_DIRECTORY = $(ROOT_DIR)/plugin
SDKMAN           = ${HOME}/.sdkman
SHARE            = ${HOME}/.cache/zsh

clean:
	rm -fr ${HOME}/.antigen
	rm -f ${HOME}/.zcompdump
	rm -f ${HOME}/.zlogin
	rm -f ${HOME}/.zlogout
	rm -f ${HOME}/.zprofile
	rm -f ${HOME}/.zshenv
	rm -f ${HOME}/.zshrc
	rm -f ${HOME}/.cache/zsh/history
	rm -fr $(PLUGIN_DIRECTORY)
	rm -fr $(SHARE)
	#
	find ${HOME} -name '*.zwc' -delete

install: | plugin
	mkdir -p $(SHARE)
	#
	ln -snf ${ROOT_DIR}/zlogin ${HOME}/.zlogin
	ln -snf ${ROOT_DIR}/zlogout ${HOME}/.zlogout
	ln -snf ${ROOT_DIR}/zprofile ${HOME}/.zprofile
	ln -snf ${ROOT_DIR}/zshenv ${HOME}/.zshenv
	ln -snf ${ROOT_DIR}/zshrc ${HOME}/.zshrc

plugin: | antigen ${FZF} ${SDKMAN}

antigen: | ${HOME}/.zsh ${ANTIGEN}

${HOME}/.zsh:
	ln -snf $(ROOT_DIR) ${HOME}/.zsh

${ANTIGEN}:
	mkdir -p ${PLUGIN_DIRECTORY}
	#
	curl --silent --location git.io/antigen --output ${ANTIGEN}

${FZF}:
	git clone --quiet git://github.com/junegunn/fzf.git ${FZF}
	#
	${FZF}/install --completion --key-bindings --no-bash --no-fish --no-update-rc

${SDKMAN}:
	curl --silent 'https://get.sdkman.io?rcupdate=false' | bash

.PHONY: install
