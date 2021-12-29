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
install: | ${HOME}/.vim dein
	mkdir -p ${CACHE}/nvim
	mkdir -p ${CACHE}/vim
	#
	mkdir -p ${NVIM}
	#
	ln -snf ${ROOT_DIR}/after ${NVIM}/after
	ln -snf ${ROOT_DIR}/config/nvimrc ${NVIM}/init.vim
	ln -snf ${ROOT_DIR}/config/vimrc ${HOME}/.vimrc

${HOME}/.vim:
	ln -snf $(ROOT_DIR) ${HOME}/.vim

dein:
	mkdir -p ${SHARE}
	mkdir -p ${SHARE}/nvim
	mkdir -p ${SHARE}/vim
	#
	curl --silent https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh --output install.sh
	#
	if [ ! -d ${SHARE}/dein.nvim ]; then bash install.sh ${SHARE}/dein.nvim; fi
	if [ ! -d ${SHARE}/dein.vim ]; then bash install.sh ${SHARE}/dein.vim; fi
	#
	rm -f install.sh

.PHONY: default
default: | clean install
