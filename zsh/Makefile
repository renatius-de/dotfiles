.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LN := ln -snf
MKDIR := mkdir -p
HOME_DIR := $(HOME)

ZSH_DIR := $(HOME_DIR)/.zsh
ZSH_CACHE := $(HOME_DIR)/.cache/zsh

DOTFILES := zshrc zshenv zlogout zprofile
ZSH_TARGETS := $(addprefix $(HOME_DIR)/.,$(DOTFILES))

ZSH_PLUGIN_DIR := $(ROOT_DIR)/plugin
ANTIGEN_DIR := $(ZSH_PLUGIN_DIR)/antigen
ANTIGEN_REPO := https://github.com/zsh-users/antigen.git

RM_F  := rm -f
RM_RF := rm -rf

CLEAN_FILES := \
  $(HOME_DIR)/.fzf.zsh \
  $(HOME_DIR)/.zcompdump \
  $(HOME_DIR)/.zsh_history \
  $(HOME_DIR)/.zshrc.zwc \
  $(ZSH_TARGETS) \
  $(ZSH_DIR)

CLEAN_DIRS := \
  $(HOME_DIR)/.zsh_sessions \
  $(HOME_DIR)/.antigen \
  $(ANTIGEN_DIR) \
  $(ZSH_PLUGIN_DIR) \
  $(ZSH_CACHE)

$(ZSH_DIR):
	$(LN) $(ROOT_DIR) $(ZSH_DIR)

$(ZSH_CACHE):
	$(MKDIR) $(ZSH_CACHE)

$(ZSH_TARGETS): $(HOME_DIR)/.%: $(ROOT_DIR)/%
	$(LN) $< $@

.PHONY: configuration install upgrade clean
configuration: | $(ZSH_DIR) $(ZSH_CACHE) $(ZSH_TARGETS)

install: | configuration
upgrade: | install

clean:
	$(RM_F)  $(CLEAN_FILES)
	$(RM_RF) $(CLEAN_DIRS)
