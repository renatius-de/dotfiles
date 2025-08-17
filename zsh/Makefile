.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LN := ln -snf
MKDIR := mkdir -p

ZSH_HOME := $(HOME)/.zsh
ZSH_CACHE_DIR := $(HOME)/.cache/zsh

DOTFILES := zshrc zshenv zlogout zprofile
ZSH_LINK_TARGETS := $(addprefix $(HOME)/.,$(DOTFILES))

PLUGINS_DIR := $(ROOT_DIR)/plugin

RM_F  := rm -f
RM_RF := rm -rf

CLEAN_FILES := \
  $(HOME)/.fzf.zsh \
  $(HOME)/.zcompdump \
  $(HOME)/.zsh_history \
  $(HOME)/.zshrc.zwc \
  $(ZSH_LINK_TARGETS) \
  $(ZSH_HOME)
CLEAN_DIRS := \
  $(HOME)/.zsh_sessions \
  $(HOME)/.antigen \
  $(PLUGINS_DIR) \
  $(ZSH_CACHE_DIR)

$(ZSH_HOME):
	$(LN) $(ROOT_DIR) $(ZSH_HOME)

$(ZSH_CACHE_DIR):
	$(MKDIR) $(ZSH_CACHE_DIR)

$(ZSH_LINK_TARGETS): $(HOME)/.%: $(ROOT_DIR)/%
	$(LN) $< $@

PHONY_TARGETS := configuration install upgrade clean
.PHONY: $(PHONY_TARGETS)

configuration: | $(ZSH_HOME) $(ZSH_CACHE_DIR) $(ZSH_LINK_TARGETS)

install: | configuration

upgrade: | install

clean:
	$(RM_F)  $(CLEAN_FILES)
	$(RM_RF) $(CLEAN_DIRS)
