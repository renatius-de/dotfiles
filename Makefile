.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
.ONESHELL:

SHELL := /bin/bash
.SHELLFLAGS := -e -u -o pipefail -c

BREW := $(shell command -v brew 2>/dev/null || \
	command -v /opt/homebrew/bin/brew 2>/dev/null || \
	command -v /usr/local/bin/brew 2>/dev/null || \
	echo "")

BREW_FORMULAS := \
	curl \
	git \
	git-flow \
	gnupg \
	go \
	gradle \
	helm \
	jenv \
	jq \
	jwt-cli \
	k9s \
	kotlin \
	kubectx \
	kubernetes-cli \
	make \
	maven \
	ncdu \
	neovim \
	node \
	pnpm \
	python \
	#

BREW_CASKS := \
	corretto \
	docker-desktop \
	jetbrains-toolbox \
	#

CLEAN_FILES := \
	$(HOME)/.asdfrc \
	$(HOME)/.calendar \
	$(HOME)/.lesshst \
	$(HOME)/.testcontainers.properties \
	#

CLEAN_DIRECTORIES := \
	$(HOME)/.asdf \
	$(HOME)/.cache \
	$(HOME)/.config/cheat \
	$(HOME)/.dlv \
	$(HOME)/.docker \
	$(HOME)/.gnupg \
	$(HOME)/.gradle \
	$(HOME)/.hawtjni \
	$(HOME)/.jenv \
	$(HOME)/.junie \
	$(HOME)/.keychain \
	$(HOME)/.kotlinc_history \
	$(HOME)/.local \
	$(HOME)/.npm \
	$(HOME)/.nvm \
	$(HOME)/.pyenv \
	$(HOME)/.rewrite-cache \
	$(HOME)/.sdkman \
	$(HOME)/.sonar \
	$(HOME)/.sonarlint \
	$(HOME)/.tool-versions \
	$(HOME)/.tree-sitter \
	$(HOME)/.vscode \
	#

EXCLUDED_SUB_DIRECTORIES :=
SUB_DIRECTORIES := $(filter-out $(EXCLUDED_SUB_DIRECTORIES),$(sort $(wildcard */)))
HOME_DEV_DIR := $(HOME)/dev

define brew_for_each
	@printf '%s\n' $(1) | xargs -n 1 -P 4 $(BREW) $(2) || true
endef

define do_in_sub_directories
	@for d in $(SUB_DIRECTORIES); do \
		if [ -f "$$d/Makefile" ]; then \
			$(MAKE) -C "$$d" $(1) || exit 1; \
		fi; \
	done
endef

.PHONY: \
	brew-cleanup \
	brew-ensure \
	brew-install \
	brew-install-packages \
	brew-outdated \
	brew-perform-upgrade \
	brew-post-install \
	brew-uninstall-packages \
	brew-update \
	brew-upgrade \
	clean \
	fix-permissions-of-home \
	install \
	upgrade

brew-ensure:
	@if [ -z "$(BREW)" ] || ! command -v "$(BREW)" >/dev/null 2>&1; then \
		echo "Error: Homebrew not found. Please install it from https://brew.sh"; \
		exit 1; \
	fi

brew-update: | brew-ensure
	@$(BREW) update

brew-install-packages: | brew-ensure
	$(call brew_for_each,$(BREW_FORMULAS),install --formula)
	$(call brew_for_each,$(BREW_CASKS),install --cask)

brew-uninstall-packages: | brew-ensure
	$(call brew_for_each,$(BREW_FORMULAS),uninstall --formula --ignore-dependencies --force)
	$(call brew_for_each,$(BREW_CASKS),uninstall --cask --ignore-dependencies --force)

brew-cleanup: | brew-ensure
	@$(BREW) autoremove
	@$(BREW) cleanup

brew-post-install: | brew-ensure
	-@$(BREW) doctor
	@$(BREW) analytics off

brew-install: | \
	brew-update \
	brew-install-packages \
	brew-cleanup \
	brew-post-install

brew-outdated: | brew-ensure
	@$(BREW) outdated

brew-perform-upgrade: | brew-ensure
	@$(BREW) upgrade

brew-upgrade: | \
	brew-update \
	brew-outdated \
	brew-perform-upgrade \
	brew-cleanup

install: | brew-install fix-permissions-of-home
	$(call do_in_sub_directories,install)

fix-permissions-of-home:
	@if [ -d "$(HOME_DEV_DIR)" ]; then \
		chmod -R u=rwX,go= "$(HOME_DEV_DIR)"; \
	fi
	@chmod u=rwX,go= "$(HOME)"

upgrade: | brew-upgrade
	$(call do_in_sub_directories,upgrade)

clean: | brew-uninstall-packages
	@$(RM) $(CLEAN_FILES)
	@$(RM) -r $(CLEAN_DIRECTORIES)
	$(call do_in_sub_directories,clean)
