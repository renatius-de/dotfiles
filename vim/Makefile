include ../make/common.mk

CACHE_DIR := $(HOME)/.cache
SHARE_DIR := $(HOME)/.local/share
NVIM_DIR := $(HOME)/.config/nvim
NVIM_INIT := $(NVIM_DIR)/init.vim
NVIM_CACHE_DIR := $(CACHE_DIR)/nvim
VIM_RC := $(HOME)/.vimrc

NVIMRC_SRC := nvimrc
VIMRC_SRC := vimrc

REQUIRED_DIRS := $(NVIM_DIR) $(NVIM_CACHE_DIR)

$(REQUIRED_DIRS):
	$(call ensure_dir,$@)

$(NVIM_INIT): | $(REQUIRED_DIRS)
	$(symlink) $(ROOT_DIR)/$(NVIMRC_SRC) $@

$(VIM_RC):
	$(symlink) $(ROOT_DIR)/$(VIMRC_SRC) $@

.PHONY: install upgrade clean

install: | $(NVIM_INIT) $(VIM_RC)

upgrade: install

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
	$(RM_F) $(CLEAN_FILES)
	$(RM_RF) $(CLEAN_DIRS)
