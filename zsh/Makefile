include ../make/common.mk

ZSH_HOME := $(HOME)/.zsh
ZSH_CACHE_DIR := $(HOME)/.cache/zsh
OH_MY_ZSH := $(HOME)/.oh-my-zsh
OMZ_CUSTOM := $(OH_MY_ZSH)/custom/plugins

EXTERNAL_PLUGINS := \
	MichaelAquilina/zsh-you-should-use \
	superbrothers/zsh-kubectl-prompt \
	zsh-users/zsh-autosuggestions \
	zsh-users/zsh-completions \
	zsh-users/zsh-syntax-highlighting

DOTFILES := zshrc zprofile
ZSH_LINK_TARGETS := $(addprefix $(HOME)/.,$(DOTFILES))
ZSHRC_LOCAL_FILE := $(HOME)/.zshrc.local

CLEAN_FILES := \
	$(HOME)/.fzf.zsh \
	$(HOME)/.zcompdump* \
	$(HOME)/.zsh_history \
	$(HOME)/.zshrc.zwc \
	$(HOME)/.zshrc.pre-oh-my-zsh \
	$(ZSH_HOME) \
	$(ZSH_LINK_TARGETS)

CLEAN_DIRECTORIES := \
	$(HOME)/.antigen \
	$(HOME)/.zsh_sessions \
	$(OH_MY_ZSH) \
	$(ZSH_CACHE_DIR)

.PHONY: ensure-git ensure-curl configuration install upgrade ohmyzsh ohmyzsh_update clone-or-update-external clean

ensure-git:
	@$(call ensure_cmd,git)

ensure-curl:
	@$(call ensure_cmd,curl)

$(ZSH_HOME):
	@$(call symlink,$(ROOT_DIR)/zsh,$@)

$(ZSH_CACHE_DIR):
	@$(call ensure_dir,$@)

$(ZSH_LINK_TARGETS): $(HOME)/.%: $(ROOT_DIR)/zsh/%
	@$(call symlink,$<,$@)

$(ZSHRC_LOCAL_FILE):
	@$(call create_local_file,$@)

ohmyzsh: ensure-git ensure-curl
	@set -o pipefail; if [ ! -d "$(OH_MY_ZSH)" ]; then \
		sh -c "$$($(DOWNLOAD) https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended; \
	fi
	@$(RM_F) $(HOME)/.zshrc

ohmyzsh_update: ensure-git
	@set -o pipefail; if [ -d "$(OH_MY_ZSH)" ]; then \
		sh $(OH_MY_ZSH)/tools/upgrade.sh > /dev/null; \
	fi
	@$(MAKE) clone-or-update-external

clone-or-update-external: ensure-git
	@$(MKDIR) $(OMZ_CUSTOM)
	@$(foreach repo,$(EXTERNAL_PLUGINS), \
		name=$$(basename $(repo)); \
		dir=$(OMZ_CUSTOM)/$$name; \
		if [ ! -d "$$dir" ]; then \
		  git clone --depth=1 https://github.com/$(repo).git "$$dir" >/dev/null \
		    || { printf "FAILED: clone %s into %s\n" "$(repo)" "$$dir" >&2; exit 1; }; \
		else \
		  git -C "$$dir" pull --ff-only >/dev/null \
		    || { printf "FAILED: update %s in %s\n" "$(repo)" "$$dir" >&2; exit 1; }; \
		fi; \
	)

configuration: | $(ZSH_HOME) $(ZSH_CACHE_DIR) $(ZSHRC_LOCAL_FILE) $(ZSH_LINK_TARGETS)

install: | ohmyzsh clone-or-update-external configuration

upgrade: | install ohmyzsh_update

clean:
	@$(RM_F) $(CLEAN_FILES)
	@$(RM_RF) $(CLEAN_DIRECTORIES)
