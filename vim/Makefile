ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CACHE = ${HOME}/.cache
NVIM = ${HOME}/.config/nvim
SHARE = ${HOME}/.local/share

.PHONY: clean
clean:
	rm -fr ${CACHE}/nvim
	rm -fr ${CACHE}/vim
	#
	rm -f ${HOME}/.ctags
	rm -f ${HOME}/.vim
	rm -f ${HOME}/.viminfo
	rm -f ${HOME}/.vimoutlinerrc
	rm -f ${HOME}/.vimpagerrc
	rm -f ${HOME}/.vimrc
	#
	rm -fr ${NVIM}
	#
	rm -fr ${SHARE}/dein.nvim
	rm -fr ${SHARE}/dein.vim
	rm -fr ${SHARE}/nvim
	rm -fr ${SHARE}/vim

.PHONY: install
install: | ${HOME}/.vim
	mkdir -p ${CACHE}/nvim
	mkdir -p ${CACHE}/vim
	#
	mkdir -p ${NVIM}
	#
	ln -snf ${ROOT_DIR}/config/nvimrc ${NVIM}/init.vim
	ln -snf ${ROOT_DIR}/config/vimrc ${HOME}/.vimrc

${HOME}/.vim:
	ln -snf $(ROOT_DIR) ${HOME}/.vim

.PHONY: default
default: | clean install
