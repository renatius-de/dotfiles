include ../make/common.mk

CACHE_DIR := $(HOME)/.cache
SHARE_DIR := $(HOME)/.local/share
NVIM_DIR := $(HOME)/.config/nvim
NVIM_INIT := $(NVIM_DIR)/init.lua
NVIM_CACHE_DIR := $(CACHE_DIR)/nvim

NVIMRC_SRC := init.lua
REQUIRED_DIRS := $(NVIM_DIR) $(NVIM_CACHE_DIR)

.PHONY: install upgrade clean

$(REQUIRED_DIRS):
	$(MKDIR) $@

$(NVIM_INIT): | $(REQUIRED_DIRS)
	$(symlink) $(ROOT_DIR)/$(NVIMRC_SRC) $@

install: | $(NVIM_INIT)

upgrade: install

CLEAN_FILES := \
	$(HOME)/.ctags \
	$(HOME)/.viminfo \
	$(HOME)/.vimoutlinerrc \
	$(HOME)/.vimpagerrc \
	$(HOME)/.vim \
	$(HOME)/.vimrc \
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
	@$(RM_F) $(CLEAN_FILES)
	@$(RM_RF) $(CLEAN_DIRS)
