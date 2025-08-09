.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY           = $(HOME)/.git
GIT_CONFIG          = $(HOME)/.gitconfig
GIT_CONFIG_LOCAL    = $(HOME)/.gitconfig.local
GIT_ATTRIBUTES      = $(ROOT_DIR)/GitAttributesRepository
GIT_IGNORE          = $(ROOT_DIR)/GitIgnoreRepository

GIT_ATTRIBUTES_URL  = https://github.com/alexkaratarakis/gitattributes.git
GIT_IGNORE_URL      = https://github.com/github/gitignore.git

define clone_repo
	git clone --quiet --depth=1 $(1) $(2)
endef

$(DIRECTORY):
	ln -snf $(ROOT_DIR) $@

$(GIT_ATTRIBUTES):
	$(call clone_repo,$(GIT_ATTRIBUTES_URL),$@)

$(GIT_IGNORE):
	$(call clone_repo,$(GIT_IGNORE_URL),$@)

$(GIT_CONFIG):
	ln -snf $(ROOT_DIR)/config $@

$(GIT_CONFIG_LOCAL):
	touch $@

pre_remove:
	-rm -rf $(GIT_ATTRIBUTES)
	-rm -rf $(GIT_IGNORE)

plugin: | $(GIT_ATTRIBUTES) $(GIT_IGNORE)

.PHONY: install upgrade pre_remove plugin
install: | $(DIRECTORY) $(GIT_CONFIG) $(GIT_CONFIG_LOCAL) plugin

upgrade: | pre_remove install

.PHONY: clean
clean:
	rm -f $(HOME)/.git_template
	rm -f $(HOME)/.gitignore
	rm -f $(HOME)/.tig_history
	#
	rm -f $(GIT_CONFIG)
	rm -f $(DIRECTORY)
	#
	rm -fr $(GIT_ATTRIBUTES)
	rm -fr $(GIT_IGNORE)
