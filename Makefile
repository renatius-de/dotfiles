.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

SHELL := /bin/bash
BREW := $(shell command -v brew 2>/dev/null || command -v /opt/homebrew/bin/brew 2>/dev/null || command -v /usr/local/bin/brew 2>/dev/null || printf brew)
BREW_FORMULAS := \
	antigen \
	curl \
	git \
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
	python
BREW_CASKS := \
	bitwarden \
	corretto \
	docker-desktop \
	google-chrome \
	jetbrains-toolbox
CLEAN_FILES := \
	$(HOME)/.asdfrc \
	$(HOME)/.calendar \
	$(HOME)/.lesshst \
	$(HOME)/.testcontainers.properties
CLEAN_DIRECTORIES := \
	$(HOME)/.asdf \
	$(HOME)/.cache \
	$(HOME)/.config/cheat \
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
	$(HOME)/.tool-versions
EXCLUDED_SUB_DIRECTORIES :=
SUB_DIRECTORIES := $(filter-out $(EXCLUDED_SUB_DIRECTORIES),$(sort $(wildcard */)))
HOME_DEV_DIR := $(HOME)/dev
RMDIR := rm -rf

define brew_for_each
	@set -e; \
	for pkg in $(1); do \
		$(BREW) $(2) $$pkg; \
	done
endef

define do_in_sub_directories
	@set -e; \
	for d in $(SUB_DIRECTORIES); do \
		if [ -d "$$d" ] && [ -f "$$d/Makefile" ]; then \
			$(MAKE) -C "$$d" $(1); \
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
	@command -v "$(BREW)" >/dev/null 2>&1 || { \
		echo "Error: Homebrew not found at '$(BREW)'."; \
		exit 1; \
	}

brew-update: | brew-ensure
	$(BREW) update

brew-install-packages: | brew-ensure
	$(call brew_for_each,$(BREW_FORMULAS),install --formula)
	$(call brew_for_each,$(BREW_CASKS),install --cask)

brew-uninstall-packages: | brew-ensure
	$(call brew_for_each,$(BREW_FORMULAS),uninstall --formula --ignore-dependencies --force)
	$(call brew_for_each,$(BREW_CASKS),uninstall --cask --ignore-dependencies --force)

brew-cleanup: | brew-ensure
	$(BREW) autoremove

brew-post-install: | brew-ensure
	$(BREW) doctor
	$(BREW) analytics off

brew-install: | \
	brew-update \
	brew-install-packages \
	brew-cleanup \
	brew-post-install

brew-outdated: | brew-ensure
	$(BREW) outdated

brew-perform-upgrade: | brew-ensure
	$(BREW) upgrade

brew-upgrade: | \
	brew-update \
	brew-outdated \
	brew-perform-upgrade \
	brew-cleanup

install: | brew-install fix-permissions-of-home
	$(call do_in_sub_directories,install)

fix-permissions-of-home:
	chmod u=rwX,go= "$(HOME)"
	chmod -R u=rwX,go= "$(HOME_DEV_DIR)"

upgrade: | brew-upgrade
	$(call do_in_sub_directories,upgrade)

clean: | brew-uninstall-packages
	$(RM) $(CLEAN_FILES)
	$(RMDIR) $(CLEAN_DIRECTORIES)
	$(call do_in_sub_directories,clean)
