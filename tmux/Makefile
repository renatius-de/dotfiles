ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

PLUGIN_DIRECTORY = plugins
TPM              = ${PLUGIN_DIRECTORY}/tpm

.PHONY: clean
clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux
	rm -f ${HOME}/.tmux.conf
	rm -f ${HOME}/.tmuxinator
	rm -fr $(PLUGIN_DIRECTORY)
	#
	gem uninstall --all --user-install tmuxinator || true

.PHONY: install
install: | plugin ${HOME}/.tmux ${HOME}/.tmuxinator
	ln -snf ${ROOT_DIR}/tmux.conf ${HOME}/.tmux.conf

${HOME}/.tmux:
	ln -snf ${ROOT_DIR} ${HOME}/.tmux

${HOME}/.tmuxinator:
	ln -snf ${ROOT_DIR}/tmuxinator ${HOME}/.tmuxinator
	#
	gem install --user-install tmuxinator

plugin: | ${TPM}
	mkdir -p $(PLUGIN_DIRECTORY)

${TPM}:
	git clone --quiet https://github.com/tmux-plugins/tpm ${TPM}

.PHONY: default
default: | clean install
