.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

BREW := $(shell command -v brew 2>/dev/null || command -v /opt/homebrew/bin/brew 2>/dev/null || command -v /usr/local/bin/brew 2>/dev/null || printf brew)

BREW_PACKAGES := \
	antigen \
	bitwarden \
	corretto \
	curl \
	docker-desktop \
	flyway \
	git \
	gitbucket \
	gnupg \
	google-chrome \
	gradle \
	helm \
	jenv \
	jetbrains-toolbox \
	jq \
	jwt-cli \
	k9s \
	kotlin \
	kubectx \
	kubernetes-cli \
	liquibase \
	make \
	maven \
	ncdu \
	neovim \
	node \
	pnpm \
	python \
	tig

CLEAN_FILES := \
	$(HOME)/.calendar \
	$(HOME)/.lesshst
CLEAN_DIRS := \
	$(HOME)/.cache \
	$(HOME)/.keychain \
	$(HOME)/.local \
	$(HOME)/.docker \
	$(HOME)/.gnupg \
	$(HOME)/.gradle \
	$(HOME)/.jenv \
	$(HOME)/.pyenv

EXCLUDED_SUB_DIRECTORIES :=
SUB_DIRECTORIES := $(filter-out $(EXCLUDED_SUB_DIRECTORIES),$(sort $(wildcard */)))

RMDIR := rm -rf

define brew_for_each_package
	@set -e; \
	for pkg in $(BREW_PACKAGES); do \
		$(BREW) $(1) $$pkg; \
	done
endef

define do_in_subdirs
	@set -e; \
	for d in $(SUB_DIRECTORIES); do \
		if [ -d "$$d" ] && [ -f "$$d/Makefile" ]; then \
			$(MAKE) -C "$$d" $(1); \
		fi; \
	done
endef

.PHONY: \
	brew-ensure \
	brew-update \
	brew-install-packages \
	brew-uninstall-packages \
	brew-cleanup \
	brew-post-install \
	brew-install \
	brew-outdated \
	brew-perform-upgrade \
	brew-upgrade \
	install \
	upgrade \
	clean

brew-ensure:
	@command -v "$(BREW)" >/dev/null 2>&1 || { \
		echo "Fehler: Homebrew nicht gefunden unter '$(BREW)'."; \
		exit 1; \
	}

brew-update: | brew-ensure
	$(BREW) update

brew-install-packages: | brew-ensure
	$(call brew_for_each_package,install)

brew-uninstall-packages: | brew-ensure
	$(call brew_for_each_package,uninstall --ignore-dependencies --force)

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
	$(call do_in_subdirs,install)

fix-permissions-of-home:
	chmod u=rwX,go= $(HOME)
	chmod -R u=rwX,go= $(HOME)/.*
	chmod -R u=rwX,go= $(HOME)/dev

upgrade: | brew-upgrade
	$(call do_in_subdirs,upgrade)

clean: | brew-uninstall-packages
	$(RM) $(CLEAN_FILES)
	$(RMDIR) $(CLEAN_DIRS)
	$(call do_in_subdirs,clean)
