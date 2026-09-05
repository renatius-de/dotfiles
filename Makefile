include make/common.mk
.DEFAULT_GOAL := help

## Homebrew detection is provided by make/common.mk (BREW, ensure_brew)

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
	jenv \
	kotlin \
	lazygit \
	make \
	ncdu \
	neovim \
	python \
	#

WORK_BREW_PACKAGES := \
	azure-cli \
	gradle \
	helm \
	k9s \
	kubectx \
	kubernetes-cli \
	maven \
	nvm \
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

## help
##   Show this help summary for the root Makefile. This target is the default when running `make` without arguments.
##   It parses inline `##` comments from target definitions in the root Makefile
##   and prints a compact list of available root-level commands.
help: ## Display Makefile help and available targets
	@printf "==> Starting target [help]...\n"
	@printf "\nAvailable targets in %s:\n\n" "$(BASE_MAKEFILE)"
	@grep -E '^[a-zA-Z0-9_.-]+:.*##' "$(BASE_MAKEFILE)" | \
		while IFS= read -r line; do \
			target=$${line%%:*}; \
			desc=$${line#*## }; \
			printf "  %-20s %s\n" "$$target" "$$desc"; \
		done
	@printf "\nRun 'make <target>' to execute a specific target.\n"
	@printf "✅ Finished target [help]\n"

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
	@printf "==> Starting target [brew-ensure]...\n"
	@$(call ensure_brew) || { $(call fail_target,brew-ensure); }
	@printf "✅ Finished target [brew-ensure]\n"

brew-update: | brew-ensure
	@printf "==> Starting target [brew-update]...\n"
	@$(BREW) update --quiet || { $(call fail_target,brew-update); }
	@printf "✅ Finished target [brew-update]\n"

brew-install-packages: | brew-ensure
	@printf "==> Starting target [brew-install-packages]...\n"
	@$(BREW) install --quiet --formula $(BREW_FORMULAS) || { $(call fail_target,brew-install-packages); }
	@$(BREW) install --quiet --cask $(BREW_CASKS) || { $(call fail_target,brew-install-packages); }
	@printf "✅ Finished target [brew-install-packages]\n"

install-homebrew-extensions: | brew-ensure
	@printf "==> Starting target [install-homebrew-extensions]...\n"
	@if [ "$(WORK_ENV)" = "true" ]; then \
		if [ -n "$(WORK_BREW_PACKAGES)" ]; then \
			$(BREW) install --quiet --formula $(WORK_BREW_PACKAGES) || { printf "ERROR: target [install-homebrew-extensions] failed while installing work Homebrew packages\n" >&2; exit 1; }; \
		else \
			printf "INFO: WORK_ENV=true but WORK_BREW_PACKAGES is empty; nothing to install.\n"; \
		fi; \
	else \
		printf "INFO: WORK_ENV!=true; skipping work environment Homebrew extensions.\n"; \
	fi
	@printf "✅ Finished target [install-homebrew-extensions]\n"

brew-uninstall-packages: | brew-ensure
	@printf "==> Starting target [brew-uninstall-packages]...\n"
	@$(BREW) uninstall --quiet --formula --ignore-dependencies --force $(BREW_FORMULAS) || { $(call fail_target,brew-uninstall-packages); }
	@$(BREW) uninstall --quiet --cask --ignore-dependencies --force $(BREW_CASKS) || { $(call fail_target,brew-uninstall-packages); }
	@printf "✅ Finished target [brew-uninstall-packages]\n"

brew-cleanup: | brew-ensure
	@printf "==> Starting target [brew-cleanup]...\n"
	@$(BREW) autoremove --quiet || { $(call fail_target,brew-cleanup); }
	@$(BREW) cleanup --quiet --prune=all || { $(call fail_target,brew-cleanup); }
	@printf "✅ Finished target [brew-cleanup]\n"

brew-post-install: | brew-ensure
	@printf "==> Starting target [brew-post-install]...\n"
	-@$(BREW) doctor --quiet || { printf "ERROR: target [brew-post-install] failed while running brew doctor\n" >&2; }
	@$(BREW) analytics off || { $(call fail_target,brew-post-install); }
	-@$(MAKE) jenv-add-corretto || { printf "ERROR: target [brew-post-install] failed while running jenv-add-corretto\n" >&2; }
	@printf "✅ Finished target [brew-post-install]\n"

jenv-add-corretto:
	@printf "==> Starting target [jenv-add-corretto]...\n"
	@set -o pipefail; if command -v jenv >/dev/null 2>&1; then \
		for jd in /Library/Java/JavaVirtualMachines/amazon-corretto*.jdk/Contents/Home; do \
			if [ -d "$$jd" ]; then \
				jenv add "$$jd" > /dev/null || { printf "ERROR: target [jenv-add-corretto] failed while registering %s\n" "$$jd" >&2; exit 1; }; \
			fi; \
		done; \
	fi
	@printf "✅ Finished target [jenv-add-corretto]\n"

brew-install: | \
	brew-update \
	brew-install-packages \
	install-homebrew-extensions \
	brew-cleanup \
	brew-post-install

brew-outdated: | brew-ensure
	@printf "==> Starting target [brew-outdated]...\n"
	@$(BREW) outdated || { $(call fail_target,brew-outdated); }
	@printf "✅ Finished target [brew-outdated]\n"

brew-perform-upgrade: | brew-ensure
	@printf "==> Starting target [brew-perform-upgrade]...\n"
	@$(BREW) upgrade || { $(call fail_target,brew-perform-upgrade); }
	@printf "✅ Finished target [brew-perform-upgrade]\n"

brew-upgrade: | \
	brew-update \
	brew-outdated \
	brew-perform-upgrade \
	brew-cleanup

## install
##   Install Homebrew packages, optional work environment extensions, and all submodule install targets.
##   Influenced by `WORK_ENV=true`. This does not perform a package upgrade unless the submodule install target does so.
install: | brew-install fix-permissions-of-home ## Install dotfiles and Homebrew packages
	@printf "==> Starting target [install]...\n"
	@$(call do_in_sub_directories,install) || { $(call fail_target,install); }
	@printf "✅ Finished target [install]\n"

## upgrade
##   Upgrade Homebrew packages and execute `upgrade` in every subdirectory.
##   Existing configuration files stay intact; modules may refresh installed runtime artifacts.
upgrade: | brew-upgrade ## Upgrade dotfiles and Homebrew packages
	@printf "==> Starting target [upgrade]...\n"
	@$(call do_in_sub_directories,upgrade) || { $(call fail_target,upgrade); }
	@printf "✅ Finished target [upgrade]\n"

## clean
##   Remove installed Homebrew packages, temporary files and configured directories.
##   Warning: this can delete caches, generated files and optional package installations.
clean: | brew-uninstall-packages ## Cleanup generated files and remove installed Homebrew packages
	@printf "==> Starting target [clean]...\n"
	@$(RM_F) $(CLEAN_FILES) || { $(call fail_target,clean); }
	@$(RM_RF) $(CLEAN_DIRECTORIES) || { $(call fail_target,clean); }
	@$(call do_in_sub_directories,clean) || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"

fix-permissions-of-home:
	@printf "==> Starting target [fix-permissions-of-home]...\n"
	@if [ -d "$(HOME_DEV_DIR)" ]; then \
		chmod -R u=rwX,go= "$(HOME_DEV_DIR)" || { printf "ERROR: target [fix-permissions-of-home] failed while fixing permissions on %s\n" "$(HOME_DEV_DIR)" >&2; exit 1; }; \
	fi
	@chmod u=rwX,go= "$(HOME)" || { printf "ERROR: target [fix-permissions-of-home] failed while fixing permissions on %s\n" "$(HOME)" >&2; exit 1; }
	@printf "✅ Finished target [fix-permissions-of-home]\n"
