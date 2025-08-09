.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

LN      := ln -snf
MKDIR   := mkdir -p
GIT     := git

ZSH_DIR      = $(HOME)/.zsh
ZSH_CACHE    = $(HOME)/.cache/zsh
ZSH_CONFIG   = $(HOME)/.zshrc
ZSH_ENV      = $(HOME)/.zshenv
ZSH_LOGOUT   = $(HOME)/.zlogout
ZSH_PROFILE  = $(HOME)/.zprofile

ZSH_PLUGIN_DIR = $(ROOT_DIR)/plugin
ANTIGEN_DIR    = $(ZSH_PLUGIN_DIR)/antigen
ANTIGEN_REPO   = https://github.com/zsh-users/antigen.git


$(ANTIGEN_DIR):
	$(MKDIR) $(ZSH_PLUGIN_DIR)
	$(GIT) clone --quiet --depth=1 $(ANTIGEN_REPO) $(ANTIGEN_DIR)

.PHONY: plugin
plugin: | $(ANTIGEN_DIR)

$(ZSH_DIR):
	$(LN) $(ROOT_DIR) $(ZSH_DIR)

$(ZSH_CACHE):
	$(MKDIR) $(ZSH_CACHE)

$(ZSH_CONFIG): SRC=$(ROOT_DIR)/zshrc
$(ZSH_CONFIG):
	$(LN) $(SRC) $@

$(ZSH_ENV): SRC=$(ROOT_DIR)/zshenv
$(ZSH_ENV):
	$(LN) $(SRC) $@

$(ZSH_LOGOUT): SRC=$(ROOT_DIR)/zlogout
$(ZSH_LOGOUT):
	$(LN) $(SRC) $@

$(ZSH_PROFILE): SRC=$(ROOT_DIR)/zprofile
$(ZSH_PROFILE):
	$(LN) $(SRC) $@

.PHONY: configuration
configuration: | \
 	$(ZSH_DIR) \
 	$(ZSH_CACHE) \
 	$(ZSH_CONFIG) \
 	$(ZSH_ENV) \
 	$(ZSH_LOGOUT) \
 	$(ZSH_PROFILE)

.PHONY: install
install: | plugin configuration

.PHONY: upgrade
upgrade: | install
	$(GIT) -C $(ANTIGEN_DIR) pull --quiet --depth=1 --update-shallow

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
