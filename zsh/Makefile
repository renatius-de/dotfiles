.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LN := ln -snf
MKDIR := mkdir -p
DOWNLOAD = curl --fail --location --silent --show-error \
	--retry 3 --retry-delay 2 --retry-all-errors --max-time 20

ZSH_HOME := $(HOME)/.zsh
ZSH_CACHE_DIR := $(HOME)/.cache/zsh
OH_MY_ZSH := $(HOME)/.oh-my-zsh
PLUGINS_DIR := $(ROOT_DIR)/plugin

OMZ_CUSTOM := $(OH_MY_ZSH)/custom/plugins
OMZ_PLUGIN_LOADER := omz-plugins.zsh

OMZ_PLUGINS := \
	aliases \
	common-aliases \
	docker \
	docker-compose \
	git \
	git-flow \
	gradle \
	history-substring-search \
	jenv \
	k9s \
	kubectl \
	mvn \
	vi-mode \
	zsh-navigation-tools
EXTERNAL_PLUGINS := \
	MichaelAquilina/zsh-you-should-use \
	superbrothers/zsh-kubectl-prompt \
	zsh-users/zsh-autosuggestions \
	zsh-users/zsh-completions \
	zsh-users/zsh-syntax-highlighting

DOTFILES := zshrc zshenv zlogout zprofile
ZSH_LINK_TARGETS := $(addprefix $(HOME)/.,$(DOTFILES))

RM_F := rm -f
RM_RF := rm -rf

CLEAN_FILES := \
	$(HOME)/.fzf.zsh \
	$(HOME)/.zcompdump \
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

PHONY_TARGETS := configuration install upgrade ohmyzsh ohmyzsh_update clone-or-update-external generate-omz-loader clean
.PHONY: $(PHONY_TARGETS)

$(ZSH_HOME):
	$(LN) $(ROOT_DIR) $(ZSH_HOME)

$(ZSH_CACHE_DIR):
	$(MKDIR) $(ZSH_CACHE_DIR)

$(ZSH_LINK_TARGETS): $(HOME)/.%: $(ROOT_DIR)/%
	$(LN) $< $@

ohmyzsh:
	@if [ ! -d "$(OH_MY_ZSH)" ]; then \
		sh -c "$$($(DOWNLOAD) https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"; \
	fi
	$(RM) $(HOME)/.zshrc

ohmyzsh_update:
	@if [ -d "$(OH_MY_ZSH)" ]; then \
		sh $(OH_MY_ZSH)/tools/upgrade.sh; \
	fi
	@$(MAKE) clone-or-update-external

clone-or-update-external:
	@mkdir -p $(OMZ_CUSTOM)
	@$(foreach repo,$(EXTERNAL_PLUGINS), \
		name=$$(basename $(repo)); \
		dir=$(OMZ_CUSTOM)/$$name; \
		if [ ! -d $$dir ]; then \
			git clone --depth=1 https://github.com/$(repo).git $$dir >/dev/null 2>&1; \
		else \
			git -C $$dir pull --ff-only >/dev/null 2>&1 || true; \
		fi; \
	)

generate-omz-loader: clone-or-update-external
	@rm -f $(OMZ_PLUGIN_LOADER)
	@$(foreach plugin,$(OMZ_PLUGINS), \
		printf "source \$$ZSH/plugins/%s/%s.plugin.zsh\n" "$(plugin)" "$(plugin)" >> $(OMZ_PLUGIN_LOADER);)
	@$(foreach repo,$(EXTERNAL_PLUGINS), \
		name=$$(basename $(repo)); \
		printf "source \$$ZSH_CUSTOM/plugins/%s/%s.plugin.zsh\n" "$$name" "$$name" >> $(OMZ_PLUGIN_LOADER);)

configuration: | $(ZSH_HOME) $(ZSH_CACHE_DIR) $(ZSH_LINK_TARGETS)

install: | ohmyzsh clone-or-update-external generate-omz-loader configuration

upgrade: | install ohmyzsh_update

clean:
	$(RM_F) $(CLEAN_FILES)
	$(RM_RF) $(CLEAN_DIRECTORIES)
