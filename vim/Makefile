ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DIRECTORY = $(HOME)/.vim
NEOVIM_DIRECTORY = $(HOME)/.config/nvim

VIM_CONFIG = $(HOME)/.vimrc
NEOVIM_CONFIG = $(NEOVIM_DIRECTORY)/init.vim

CACHE = $(HOME)/.cache
VIM_CACHE = $(CACHE)/vim
NEOVIM_CACHE = $(CACHE)/nvim

SHARE = $(HOME)/.local/share

$(DIRECTORY):
	ln -snf $(ROOT_DIR) $(DIRECTORY)

$(NEOVIM_CACHE):
	mkdir -p $(NEOVIM_CACHE)

$(NEOVIM_CONFIG): | $(NEOVIM_DIRECTORY)
	ln -snf $(ROOT_DIR)/config/nvimrc $(NEOVIM_CONFIG)

$(NEOVIM_DIRECTORY):
	mkdir -p $(NEOVIM_DIRECTORY)

$(VIM_CACHE):
	mkdir -p $(VIM_CACHE)

$(VIM_CONFIG):
	ln -snf $(ROOT_DIR)/vimrc $(VIM_CONFIG)

.PHONY: clean
clean:
	rm -f $(HOME)/.ctags
	rm -f $(HOME)/.viminfo
	rm -f $(HOME)/.vimoutlinerrc
	rm -f $(HOME)/.vimpagerrc
	#
	rm -fr $(SHARE)/dein.nvim
	rm -fr $(SHARE)/dein.vim
	rm -fr $(SHARE)/nvim
	rm -fr $(SHARE)/vim
	#
	rm -f $(DIRECTORY)
	rm -fr $(NEOVIM_DIRECTORY)
	#
	rm -f $(VIM_CONFIG)
	rm -f $(NEOVIM_CONFIG)
	#
	rm -fr $(VIM_CACHE)
	rm -fr $(NEOVIM_CACHE)

.PHONY: install
install: | $(DIRECTORY) $(VIM_CONFIG) $(NEOVIM_CONFIG) $(VIM_CACHE) $(NEOVIM_CACHE)

.PHONY: upgrade
upgrade: | install
