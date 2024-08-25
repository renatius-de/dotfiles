.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ZSH_DIR = $(HOME)/.zsh
ZSH_CACHE = $(HOME)/.cache/zsh
ZSH_CONFIG = $(HOME)/.zshrc
ZSH_ENV = $(HOME)/.zshenv
ZSH_LOGOUT = $(HOME)/.zlogout
ZSH_PROFILE = $(HOME)/.zprofile
ZSH_PLUGIN_DIR = $(ROOT_DIR)/plugin

ANTIGEN = $(ZSH_PLUGIN_DIR)/antigen

$(ANTIGEN):
	mkdir -p $(ZSH_PLUGIN_DIR)
	#
	git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git $(ANTIGEN)

plugin: | $(ANTIGEN)

$(ZSH_DIR):
	ln -snf $(ROOT_DIR) $(ZSH_DIR)

$(ZSH_CACHE):
	mkdir -p $(ZSH_CACHE)

$(ZSH_CONFIG):
	ln -snf $(ROOT_DIR)/zshrc $(ZSH_CONFIG)

$(ZSH_ENV):
	ln -snf $(ROOT_DIR)/zshenv $(ZSH_ENV)

$(ZSH_LOGOUT):
	ln -snf $(ROOT_DIR)/zlogout $(ZSH_LOGOUT)

$(ZSH_PROFILE):
	ln -snf $(ROOT_DIR)/zprofile $(ZSH_PROFILE)

configuration: | \
 	$(ZSH_DIR) \
 	$(ZSH_CACHE) \
 	$(ZSH_CONFIG) \
 	$(ZSH_ENV) \
 	$(ZSH_LOGOUT) \
 	$(ZSH_PROFILE) \
	#

.PHONY: install
install: | plugin configuration

.PHONY: upgrade
upgrade: | install
	git -C $(ANTIGEN) pull --quiet --depth=1 --update-shallow

.PHONY: clean
clean:
	rm -f $(HOME)/.fzf.zsh
	rm -f $(HOME)/.zcompdump
	rm -f $(HOME)/.zsh_history
	rm -f $(HOME)/.zshrc.zwc
	rm -rf $(HOME)/.zsh_sessions
	#
	rm -fr $(HOME)/.antigen
	rm -fr $(ANTIGEN)
	#
	rm -fr $(ZSH_PLUGIN_DIR)
	rm -fr $(ZSH_CACHE)
	#
	rm -f $(ZSH_DIR)
	rm -f $(ZSH_CONFIG)
	rm -f $(ZSH_ENV)
	rm -f $(ZSH_LOGOUT)
	rm -f $(ZSH_PROFILE)
