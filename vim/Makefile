.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR          := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CACHE_DIR         := $(HOME)/.cache
SHARE_DIR         := $(HOME)/.local/share
NVIM_DIR          := $(HOME)/.config/nvim
NVIM_INIT         := $(NVIM_DIR)/init.vim
NVIM_CACHE_DIR    := $(CACHE_DIR)/nvim
VIM_RC            := $(HOME)/.vimrc

# Hilfsfunktionen
define mk_dir
	mkdir -p $(1)
endef

define ln_from_root
	ln -snf $(ROOT_DIR)/$(1) $(2)
endef

# Verzeichnisse
$(NVIM_CACHE_DIR):
	$(call mk_dir,$@)

$(NVIM_DIR):
	$(call mk_dir,$@)

# Symlinks
$(NVIM_INIT): | $(NVIM_DIR) $(NVIM_CACHE_DIR)
	$(call ln_from_root,nvimrc,$@)

$(VIM_RC):
	$(call ln_from_root,vimrc,$@)

.PHONY: install upgrade clean
install: | $(NVIM_INIT) $(VIM_RC)

upgrade: | install

# Aufräumen
CLEAN_FILES := \
	$(HOME)/.ctags \
	$(HOME)/.viminfo \
	$(HOME)/.vimoutlinerrc \
	$(HOME)/.vimpagerrc \
	$(HOME)/.vim \
	$(VIM_RC) \
	$(NVIM_INIT)

CLEAN_DIRS := \
	$(SHARE_DIR)/dein.nvim \
	$(SHARE_DIR)/dein.vim \
	$(SHARE_DIR)/nvim \
	$(SHARE_DIR)/vim \
	$(NVIM_DIR) \
	$(CACHE_DIR)/vim \
	$(NVIM_CACHE_DIR)

clean:
	-rm -f $(CLEAN_FILES)
	-rm -rf $(CLEAN_DIRS)
