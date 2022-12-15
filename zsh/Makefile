ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.zsh
ZSH_CONFIG = $(HOME)/.zshrc
ZSH_ENV = $(HOME)/.zshenv
ZSH_LOGOUT = $(HOME)/.zlogout
ZSH_PROFILE = $(HOME)/.zprofile

ANTIGEN = ${PLUGIN_DIRECTORY}/antigen
PLUGIN_DIRECTORY = $(ROOT_DIR)/plugin
SDKMAN = $(HOME)/.sdkman
SHARE = $(HOME)/.cache/zsh

${ANTIGEN}:
	mkdir -p ${PLUGIN_DIRECTORY}
	#
	git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git ${ANTIGEN}

$(SDKMAN):
	curl --silent 'https://get.sdkman.io?rcupdate=false' | bash

plugin: | $(ANTIGEN) $(SDKMAN)

$(DIRECTORY):
	ln -snf $(ROOT_DIR) $(DIRECTORY)

$(SHARE):
	mkdir -p $(SHARE)

$(ZSH_CONFIG):
	ln -snf $(ROOT_DIR)/zshrc $(ZSH_CONFIG)

$(ZSH_ENV):
	ln -snf $(ROOT_DIR)/zshenv $(ZSH_ENV)

$(ZSH_LOGOUT):
	ln -snf $(ROOT_DIR)/zlogout $(ZSH_LOGOUT)

$(ZSH_PROFILE):
	ln -snf $(ROOT_DIR)/zprofile $(ZSH_PROFILE)

.PHONY: clean
clean:
	rm -f $(HOME)/.fzf.zsh
	rm -f $(HOME)/.zcompdump
	rm -f $(HOME)/.zsh_history
	rm -f $(HOME)/.zshrc.zwc
	rm -rf $(HOME)/.npm
	rm -rf $(HOME)/.nvm
	rm -rf $(HOME)/.zsh_sessions
	#
	rm -fr $(HOME)/.antigen
	rm -fr $(ANTIGEN)
	rm -fr $(SDKMAN)
	#
	rm -fr $(PLUGIN_DIRECTORY)
	rm -fr $(SHARE)
	#
	rm -f $(DIRECTORY)
	rm -f $(ZSH_CONFIG)
	rm -f $(ZSH_ENV)
	rm -f $(ZSH_LOGOUT)
	rm -f $(ZSH_PROFILE)

configuration: | $(DIRECTORY) $(SHARE) $(ZSH_CONFIG) $(ZSH_ENV) $(ZSH_LOGOUT) $(ZSH_PROFILE)

.PHONY: install
install: | plugin configuration
