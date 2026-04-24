.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_DIR_SYMLINK := $(HOME)/.git
GIT_CONFIG_FILE := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE := $(HOME)/.gitconfig.local
GITATTR_REPO_DIR := $(ROOT_DIR)/GitAttributesRepository
GITIGNORE_REPO_DIR := $(ROOT_DIR)/GitIgnoreRepository
REPO_DIRS := $(GITATTR_REPO_DIR) $(GITIGNORE_REPO_DIR)

GIT_ATTRIBUTES_URL := https://github.com/alexkaratarakis/gitattributes.git
GIT_IGNORE_URL := https://github.com/github/gitignore.git

define git_clone_shallow
	git clone --quiet --depth=1 $(1) $(2)
endef

$(GIT_DIR_SYMLINK):
	ln -snf $(ROOT_DIR) $@

$(GITATTR_REPO_DIR):
	$(call git_clone_shallow,$(GIT_ATTRIBUTES_URL),$@)

$(GITIGNORE_REPO_DIR):
	$(call git_clone_shallow,$(GIT_IGNORE_URL),$@)

$(GIT_CONFIG_FILE):
	ln -snf $(ROOT_DIR)/config $@

$(GIT_CONFIG_LOCAL_FILE):
	touch $@

.PHONY: install upgrade plugin clean

plugin: $(REPO_DIRS)

install: $(GIT_DIR_SYMLINK) $(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) plugin

upgrade: install
	rm -rf $(REPO_DIRS)

clean:
	rm -f $(HOME)/.git_template $(HOME)/.gitignore $(HOME)/.tig_history $(GIT_CONFIG_FILE) $(GIT_DIR_SYMLINK)
	rm -rf $(REPO_DIRS)
