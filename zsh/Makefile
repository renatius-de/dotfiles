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
ZSH_COPY_TARGETS := $(addprefix $(HOME)/.,$(DOTFILES))
ZSHRC_LOCAL_FILE := $(HOME)/.zshrc.local

CLEAN_FILES := \
	$(HOME)/.fzf.zsh \
	$(HOME)/.zcompdump* \
	$(HOME)/.zsh_history \
	$(HOME)/.zshrc.zwc \
	$(HOME)/.zshrc.pre-oh-my-zsh \
	$(ZSH_HOME) \
	$(ZSH_COPY_TARGETS)

CLEAN_DIRECTORIES := \
	$(HOME)/.antigen \
	$(HOME)/.zsh_sessions \
	$(OH_MY_ZSH) \
	$(ZSH_CACHE_DIR)

.PHONY: ensure-git ensure-curl configuration install upgrade ohmyzsh ohmyzsh_update clone-or-update-external clean \
	$(ZSH_HOME) $(ZSH_COPY_TARGETS) $(ZSHRC_LOCAL_FILE)

ensure-git:
	$(call target_start,ensure-git)
	@$(call ensure_cmd,git,ensure-git) || { $(call fail_target,ensure-git); }
	$(call target_end,ensure-git)

ensure-curl:
	$(call target_start,ensure-curl)
	@$(call ensure_cmd,curl,ensure-curl) || { $(call fail_target,ensure-curl); }
	$(call target_end,ensure-curl)

$(ZSH_HOME):
	$(call link_tree_to_target,configuration,$@,$(ROOT_DIR)/zsh)

$(ZSH_CACHE_DIR):
	$(call ensure_directory,$@,configuration)
	@printf "✅ Ready: [%s]\n" "$@"

$(ZSH_COPY_TARGETS): $(HOME)/.%: $(ROOT_DIR)/zsh/%
	$(call link_file_to_target,configuration,$@,$<)

$(ZSHRC_LOCAL_FILE):
	@printf "==> Creating local Zsh config [%s]\n" "$@"
	@$(call create_local_file,$@) || { $(call fail_target,configuration); }
	@printf "✅ Ready: [%s]\n" "$@"

ohmyzsh: ensure-git ensure-curl
	$(call target_start,ohmyzsh)
	@set -o pipefail; if [ ! -d "$(OH_MY_ZSH)" ]; then \
		sh -c "$$($(DOWNLOAD) https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended || { printf "ERROR: target [ohmyzsh] failed while installing Oh My Zsh\n" >&2; exit 1; }; \
	fi
	@$(RM_F) $(HOME)/.zshrc || { $(call fail_target,ohmyzsh); }
	$(call target_end,ohmyzsh)

ohmyzsh_update: ensure-git
	$(call target_start,ohmyzsh_update)
	@set -o pipefail; if [ -d "$(OH_MY_ZSH)" ]; then \
		sh $(OH_MY_ZSH)/tools/upgrade.sh > /dev/null || { printf "ERROR: target [ohmyzsh_update] failed while upgrading Oh My Zsh\n" >&2; exit 1; }; \
	fi
	@$(MAKE) clone-or-update-external || { $(call fail_target,ohmyzsh_update); }
	$(call target_end,ohmyzsh_update)

clone-or-update-external: ensure-git
	$(call target_start,clone-or-update-external)
	@$(MKDIR) $(OMZ_CUSTOM) || { $(call fail_target,clone-or-update-external); }
	@$(foreach repo,$(EXTERNAL_PLUGINS), \
		name=$$(basename $(repo)); \
		dir=$(OMZ_CUSTOM)/$$name; \
		if [ ! -d "$$dir" ]; then \
		  git clone --depth=1 https://github.com/$(repo).git "$$dir" >/dev/null \
		    || { printf "ERROR: target [clone-or-update-external] failed while cloning %s into %s\n" "$(repo)" "$$dir" >&2; exit 1; }; \
		else \
		  git -C "$$dir" pull --ff-only >/dev/null \
		    || { printf "ERROR: target [clone-or-update-external] failed while updating %s in %s\n" "$(repo)" "$$dir" >&2; exit 1; }; \
		fi; \
	)
	$(call target_end,clone-or-update-external)

configuration: | $(ZSH_HOME) $(ZSH_CACHE_DIR) $(ZSHRC_LOCAL_FILE) $(ZSH_COPY_TARGETS)
	$(call target_start,configuration)
	$(call target_end,configuration)

install: | ohmyzsh clone-or-update-external configuration
	$(call target_start,install)
	$(call target_end,install)

upgrade: | install ohmyzsh_update
	$(call target_start,upgrade)
	$(call target_end,upgrade)

clean:
	$(call target_start,clean)
	@$(RM_F) $(CLEAN_FILES) || { $(call fail_target,clean); }
	@$(RM_RF) $(CLEAN_DIRECTORIES) || { $(call fail_target,clean); }
	$(call target_end,clean)
