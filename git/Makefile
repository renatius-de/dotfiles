.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.git
GIT_CONFIG = $(HOME)/.gitconfig

GIT_ATTRIBUTES = $(ROOT_DIR)/GitAttributesRepository
GIT_IGNORE = $(ROOT_DIR)/GitIgnoreRepository

$(DIRECTORY):
	ln -snf $(ROOT_DIR) $(DIRECTORY)

$(GIT_ATTRIBUTES):
	git clone --quiet --depth=1 https://github.com/alexkaratarakis/gitattributes.git $(GIT_ATTRIBUTES)

$(GIT_CONFIG):
	ln -snf $(ROOT_DIR)/config $(GIT_CONFIG)

$(HOME)/.gitconfig.local:
	touch $(HOME)/.gitconfig.local

$(GIT_IGNORE):
	git clone --quiet --depth=1 https://github.com/github/gitignore.git $(GIT_IGNORE)

plugin: | $(GIT_ATTRIBUTES) $(GIT_IGNORE)

.PHONY: install
install: | $(DIRECTORY) $(GIT_CONFIG) plugin

.PHONY: upgrade
upgrade: | install
	git -C $(GIT_ATTRIBUTES) pull --depth=1 --quiet --update-shallow
	#
	git -C $(GIT_IGNORE) pull --depth=1 --quiet --update-shallow

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
