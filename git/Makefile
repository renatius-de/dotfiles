.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_DIR_SYMLINK        := $(HOME)/.git
GIT_CONFIG_FILE        := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE  := $(HOME)/.gitconfig.local

GITATTR_REPO_DIR       := $(ROOT_DIR)/GitAttributesRepository
GITIGNORE_REPO_DIR     := $(ROOT_DIR)/GitIgnoreRepository
GIT_ATTRIBUTES_URL     := https://github.com/alexkaratarakis/gitattributes.git
GIT_IGNORE_URL         := https://github.com/github/gitignore.git

LN_SNF := ln -snf
RM_F   := rm -f
RM_RF  := rm -rf

REPO_DIRS := $(GITATTR_REPO_DIR) $(GITIGNORE_REPO_DIR)

define git_clone_shallow
	git clone --quiet --depth=1 $(1) $(2)
endef

# Ziele
$(GIT_DIR_SYMLINK):
	$(LN_SNF) $(ROOT_DIR) $@

$(GITATTR_REPO_DIR):
	$(call git_clone_shallow,$(GIT_ATTRIBUTES_URL),$@)

$(GITIGNORE_REPO_DIR):
	$(call git_clone_shallow,$(GIT_IGNORE_URL),$@)

$(GIT_CONFIG_FILE):
	$(LN_SNF) $(ROOT_DIR)/config $@

$(GIT_CONFIG_LOCAL_FILE):
	touch $@

pre_remove:
	-$(RM_RF) $(REPO_DIRS)

plugin: | $(REPO_DIRS)

install: $(GIT_DIR_SYMLINK) $(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) plugin
upgrade: pre_remove install

.PHONY: install upgrade pre_remove plugin clean

clean:
	$(RM_F) $(HOME)/.git_template $(HOME)/.gitignore $(HOME)/.tig_history $(GIT_CONFIG_FILE) $(GIT_DIR_SYMLINK)
	$(RM_RF) $(REPO_DIRS)
