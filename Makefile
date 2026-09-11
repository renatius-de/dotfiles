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
	$(call target_start,help)
	@printf "\nAvailable targets in %s:\n\n" "$(BASE_MAKEFILE)"
	@grep -E '^[a-zA-Z0-9_.-]+:.*##' "$(BASE_MAKEFILE)" | \
		while IFS= read -r line; do \
			target=$${line%%:*}; \
			desc=$${line#*## }; \
			printf "  %-20s %s\n" "$$target" "$$desc"; \
		done
	@printf "\nRun 'make <target>' to execute a specific target.\n"
	$(call target_end,help)

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
	$(call target_start,brew-ensure)
	@$(call ensure_brew)
	$(call target_end,brew-ensure)

brew-update: | brew-ensure
	$(call target_start,brew-update)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-update] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-update] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) update --quiet || { $(call fail_target,brew-update); }; \
	fi
	$(call target_end,brew-update)

brew-install-packages: | brew-ensure
	$(call target_start,brew-install-packages)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-install-packages] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-install-packages] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) install --quiet --formula $(BREW_FORMULAS) || { $(call fail_target,brew-install-packages); }; \
		$(BREW) install --quiet --cask $(BREW_CASKS) || { $(call fail_target,brew-install-packages); }; \
	fi
	$(call target_end,brew-install-packages)

install-homebrew-extensions: | brew-ensure
	$(call target_start,install-homebrew-extensions)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [install-homebrew-extensions] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [install-homebrew-extensions] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	elif [ "$(WORK_ENV)" = "true" ]; then \
		if [ -n "$(WORK_BREW_PACKAGES)" ]; then \
			$(BREW) install --quiet --formula $(WORK_BREW_PACKAGES) || { printf "ERROR: target [install-homebrew-extensions] failed while installing work Homebrew packages\n" >&2; exit 1; }; \
		else \
			printf "INFO: WORK_ENV=true but WORK_BREW_PACKAGES is empty; nothing to install.\n"; \
		fi; \
	else \
		printf "INFO: WORK_ENV!=true; skipping work environment Homebrew extensions.\n"; \
	fi
	$(call target_end,install-homebrew-extensions)

brew-uninstall-packages: | brew-ensure
	$(call target_start,brew-uninstall-packages)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-uninstall-packages] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-uninstall-packages] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) uninstall --quiet --formula --ignore-dependencies --force $(BREW_FORMULAS) || { $(call fail_target,brew-uninstall-packages); }; \
		$(BREW) uninstall --quiet --cask --ignore-dependencies --force $(BREW_CASKS) || { $(call fail_target,brew-uninstall-packages); }; \
	fi
	$(call target_end,brew-uninstall-packages)

brew-cleanup: | brew-ensure
	$(call target_start,brew-cleanup)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-cleanup] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-cleanup] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) autoremove --quiet || { $(call fail_target,brew-cleanup); }; \
		$(BREW) cleanup --quiet --prune=all || { $(call fail_target,brew-cleanup); }; \
	fi
	$(call target_end,brew-cleanup)

brew-post-install: | brew-ensure
	$(call target_start,brew-post-install)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-post-install] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-post-install] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) doctor --quiet || printf "ERROR: target [brew-post-install] failed while running brew doctor\n" >&2; \
		$(BREW) analytics off || { $(call fail_target,brew-post-install); }; \
		$(MAKE) jenv-add-corretto || printf "ERROR: target [brew-post-install] failed while running jenv-add-corretto\n" >&2; \
	fi
	$(call target_end,brew-post-install)

jenv-add-corretto:
	$(call target_start,jenv-add-corretto)
	@set -o pipefail; if command -v jenv >/dev/null 2>&1; then \
		for jd in /Library/Java/JavaVirtualMachines/amazon-corretto*.jdk/Contents/Home; do \
			if [ -d "$$jd" ]; then \
				jenv add "$$jd" > /dev/null || { printf "ERROR: target [jenv-add-corretto] failed while registering %s\n" "$$jd" >&2; exit 1; }; \
			fi; \
		done; \
	fi
	$(call target_end,jenv-add-corretto)

brew-install: | \
	brew-update \
	brew-install-packages \
	install-homebrew-extensions \
	brew-cleanup \
	brew-post-install
	$(call make_summary)

brew-outdated: | brew-ensure
	$(call target_start,brew-outdated)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-outdated] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-outdated] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) outdated || { $(call fail_target,brew-outdated); }; \
	fi
	$(call target_end,brew-outdated)

brew-perform-upgrade: | brew-ensure
	$(call target_start,brew-perform-upgrade)
	@if [ "$(BREW_AVAILABLE)" != "true" ]; then \
		printf "INFO: target [brew-perform-upgrade] skipped because Homebrew is not installed.\n"; \
		printf "BREW_SKIP: target [brew-perform-upgrade] was skipped because Homebrew is not installed.\n" >> "$(MAKE_STATUS_FILE)"; \
	else \
		$(BREW) upgrade || { $(call fail_target,brew-perform-upgrade); }; \
	fi
	$(call target_end,brew-perform-upgrade)

brew-upgrade: | \
	brew-update \
	brew-outdated \
	brew-perform-upgrade \
	brew-cleanup
	$(call make_summary)

## install
##   Install Homebrew packages, optional work environment extensions, and all submodule install targets.
##   Influenced by `WORK_ENV=true`. This does not perform a package upgrade unless the submodule install target does so.
install: | brew-install fix-permissions-of-home ## Install dotfiles and Homebrew packages
	$(call target_start,install)
	@$(call do_in_sub_directories,install) || { $(call fail_target,install); }
	$(call target_end,install)
	$(call make_summary)

## upgrade
##   Upgrade Homebrew packages and execute `upgrade` in every subdirectory.
##   Existing configuration files stay intact; modules may refresh installed runtime artifacts.
upgrade: | brew-upgrade ## Upgrade dotfiles and Homebrew packages
	$(call target_start,upgrade)
	@$(call do_in_sub_directories,upgrade) || { $(call fail_target,upgrade); }
	$(call target_end,upgrade)
	$(call make_summary)

## clean
##   Remove installed Homebrew packages, temporary files and configured directories.
##   Warning: this can delete caches, generated files and optional package installations.
clean: | brew-uninstall-packages ## Cleanup generated files and remove installed Homebrew packages
	$(call target_start,clean)
	@$(RM_F) $(CLEAN_FILES) || { $(call fail_target,clean); }
	@$(RM_RF) $(CLEAN_DIRECTORIES) || { $(call fail_target,clean); }
	@$(call do_in_sub_directories,clean) || { $(call fail_target,clean); }
	$(call target_end,clean)
	@printf "✅ Finished target [clean]\n"
	$(call make_summary)

fix-permissions-of-home:
	@printf "==> Starting target [fix-permissions-of-home]...\n"
	@if [ -d "$(HOME_DEV_DIR)" ]; then \
		chmod -R u=rwX,go= "$(HOME_DEV_DIR)" || { printf "ERROR: target [fix-permissions-of-home] failed while fixing permissions on %s\n" "$(HOME_DEV_DIR)" >&2; exit 1; }; \
	fi
	@chmod u=rwX,go= "$(HOME)" || { printf "ERROR: target [fix-permissions-of-home] failed while fixing permissions on %s\n" "$(HOME)" >&2; exit 1; }
	@printf "✅ Finished target [fix-permissions-of-home]\n"
