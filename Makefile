include make/common.mk
.DEFAULT_GOAL := help

BREW := $(shell command -v brew 2>/dev/null || command -v /opt/homebrew/bin/brew 2>/dev/null || command -v /usr/local/bin/brew 2>/dev/null || echo)

BREW_FORMULAS := \
	bat \
	btop \
	curl \
	delta \
	eza \
	gh \
	git \
	gnupg \
	go \
	kotlin \
	lazygit \
	make \
	ncdu \
	neovim \
	python \
	#

WORK_BREW_PACKAGES := \
	gradle \
	helm \
	jenv \
	k9s \
	kubectx \
	kubernetes-cli \
	maven \
	node \
	pnpm \
	stern \
	yq \
	#

BREW_CASKS := \
	corretto \
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

define do_in_sub_directories
	@for d in $(SUB_DIRECTORIES); do \
		if [ -f "$$d/Makefile" ]; then \
			printf "➔ Entering directory: %s\n" "$$d"; \
			$(MAKE) -C "$$d" $(1) || { printf "FAILED: Target [%s] in Makefile [%s/Makefile] failed\n" "$(1)" "$$d" >&2; exit 1; }; \
			printf "✔ Done directory: %s\n" "$$d"; \
		fi; \
	done
endef

## help
##   Show this help summary for the root Makefile. This target is the default when running `make` without arguments.
##   It parses inline `##` comments from target definitions in the root Makefile
##   and prints a compact list of available root-level commands.
help: ## Display Makefile help and available targets
	@printf "➔ Starting target [help]...\n"
	@printf "\nAvailable targets in %s:\n\n" "$(BASE_MAKEFILE)"
	@grep -E '^[a-zA-Z0-9_.-]+:.*##' "$(BASE_MAKEFILE)" | \
		while IFS= read -r line; do \
			target=$${line%%:*}; \
			desc=$${line#*## }; \
			printf "  %-20s %s\n" "$$target" "$$desc"; \
		done
	@printf "\nRun 'make <target>' to execute a specific target.\n"
	@printf "✔ Done target [help]\n"

.PHONY: \
	help \
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
	install-homebrew-extensions \
	upgrade \
	jenv-add-corretto

brew-ensure:
	@if [ -z "$(BREW)" ] || ! command -v "$(BREW)" >/dev/null 2>&1; then \
		printf "Error: Homebrew not found. Please install it from https://brew.sh\n" >&2; \
		exit 1; \
	fi

brew-update: | brew-ensure
	@$(BREW) update --quiet

brew-install-packages: | brew-ensure
	@$(BREW) install --quiet --formula $(BREW_FORMULAS)
	@$(BREW) install --quiet --cask $(BREW_CASKS)

install-homebrew-extensions: | brew-ensure
	@if [ "$(WORK_ENV)" = "true" ]; then \
		if [ -n "$(WORK_BREW_PACKAGES)" ]; then \
			$(BREW) install --quiet --formula $(WORK_BREW_PACKAGES); \
		else \
			printf "WORK_ENV=true but WORK_BREW_PACKAGES is empty; nothing to install.\n"; \
		fi; \
	else \
		printf "WORK_ENV!=true; skipping work environment Homebrew extensions.\n"; \
	fi

brew-uninstall-packages: | brew-ensure
	@$(BREW) uninstall --quiet --formula --ignore-dependencies --force $(BREW_FORMULAS)
	@$(BREW) uninstall --quiet --cask --ignore-dependencies --force $(BREW_CASKS)

brew-cleanup: | brew-ensure
	@$(BREW) autoremove --quiet
	@$(BREW) cleanup --quiet --prune=all

brew-post-install: | brew-ensure
	-@$(BREW) doctor --quiet
	@$(BREW) analytics off
	-@$(MAKE) jenv-add-corretto

jenv-add-corretto:
	@set -o pipefail; if command -v jenv >/dev/null 2>&1; then \
		for jd in /Library/Java/JavaVirtualMachines/amazon-corretto*.jdk/Contents/Home; do \
			if [ -d "$$jd" ]; then \
				jenv add "$$jd"; \
			fi; \
		done; \
	fi

brew-install: | \
	brew-update \
	brew-install-packages \
	install-homebrew-extensions \
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

## install
##   Install Homebrew packages, optional work environment extensions, and all submodule install targets.
##   Influenced by `WORK_ENV=true`. This does not perform a package upgrade unless the submodule install target does so.
install: | brew-install fix-permissions-of-home ## Install dotfiles and Homebrew packages
	@printf "➔ Starting target [install]...\n"
	@$(call do_in_sub_directories,install)
	@printf "✔ Done target [install]\n"

## upgrade
##   Upgrade Homebrew packages and execute `upgrade` in every subdirectory.
##   Existing configuration files stay intact; modules may refresh symlinks and other runtime artifacts.
upgrade: | brew-upgrade ## Upgrade dotfiles and Homebrew packages
	@printf "➔ Starting target [upgrade]...\n"
	@$(call do_in_sub_directories,upgrade)
	@printf "✔ Done target [upgrade]\n"

## clean
##   Remove installed Homebrew packages, temporary files and configured directories.
##   Warning: this can delete caches, generated files and optional package installations.
clean: | brew-uninstall-packages ## Cleanup generated files and remove installed Homebrew packages
	@printf "➔ Starting target [clean]...\n"
	@$(RM_F) $(CLEAN_FILES)
	@$(RM_RF) $(CLEAN_DIRECTORIES)
	@$(call do_in_sub_directories,clean)
	@printf "✔ Done target [clean]\n"

fix-permissions-of-home:
	@if [ -d "$(HOME_DEV_DIR)" ]; then \
		chmod -R u=rwX,go= "$(HOME_DEV_DIR)"; \
	fi
	@chmod u=rwX,go= "$(HOME)"
