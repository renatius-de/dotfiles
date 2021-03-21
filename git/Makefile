ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY   = $(ROOT_DIR)/GitIgnoreRepository
GIT_TEMPLATE_REPOSITORY = $(ROOT_DIR)/GitTemplate

clean:
	rm -f ${HOME}/.git_template
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -f ${HOME}/.tig_history
	rm -fr $(GIT_IGNORE_REPOSITORY)
	rm -fr $(GIT_TEMPLATE_REPOSITORY)

install: | ${HOME}/.git plugin
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

${HOME}/.git:
	ln -snf $(ROOT_DIR) ${HOME}/.git

$(GIT_IGNORE_REPOSITORY):
	git clone --quiet git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

plugin: | $(GIT_IGNORE_REPOSITORY)

.PHONY: install
