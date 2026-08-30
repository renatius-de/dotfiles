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
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(NVIM_INIT): | $(REQUIRED_DIRS)
	@printf "==> Installing Neovim config from [%s] to [%s]\n" "$(ROOT_DIR)/$(NVIMRC_SRC)" "$@"
	@$(call ensure_dir,$(dir $@)) || { $(call fail_target,install); }
	@$(COPY_FILE) "$(ROOT_DIR)/$(NVIMRC_SRC)" "$@" || { printf "ERROR: target [install] failed while copying %s to %s\n" "$(ROOT_DIR)/$(NVIMRC_SRC)" "$@" >&2; exit 1; }
	@printf "✅ Installed Neovim config to [%s]\n" "$@"

install: | $(NVIM_INIT)
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

upgrade: install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"

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
	@printf "==> Starting target [clean]...\n"
	@$(RM_F) $(CLEAN_FILES) || { $(call fail_target,clean); }
	@$(RM_RF) $(CLEAN_DIRS) || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"
