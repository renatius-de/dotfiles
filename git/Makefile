ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_ATTRIBUTES_REPOSITORY = $(ROOT_DIR)/GitAttributesRepository
GIT_IGNORE_REPOSITORY = $(ROOT_DIR)/GitIgnoreRepository

.PHONY: clean
clean:
	rm -f ${HOME}/.git
	rm -f ${HOME}/.git_template
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -f ${HOME}/.tig_history
	rm -fr $(GIT_ATTRIBUTES_REPOSITORY)
	rm -fr $(GIT_IGNORE_REPOSITORY)
	rm -fr $(ROOT_DIR)/GitTemplate

.PHONY: install
install: | ${HOME}/.git plugin
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

${HOME}/.git:
	ln -snf $(ROOT_DIR) ${HOME}/.git

$(GIT_ATTRIBUTES_REPOSITORY):
	git clone --quiet https://github.com/alexkaratarakis/gitattributes.git $(GIT_ATTRIBUTES_REPOSITORY)

$(GIT_IGNORE_REPOSITORY):
	git clone --quiet https://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

plugin: | $(GIT_ATTRIBUTES_REPOSITORY) $(GIT_IGNORE_REPOSITORY)

.PHONY: default
default: | clean install
