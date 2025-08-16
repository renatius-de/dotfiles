.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

BREW := $(shell command -v brew 2>/dev/null || printf /opt/homebrew/bin/brew)

# Zentrale Paketliste
BREW_PACKAGES := \
	antigen \
	bitwarden \
	curl \
	docker-desktop \
	flyway \
	git \
	gitbucket \
	gnupg \
	google-chrome \
	gradle \
	jenv \
	jetbrains-toolbox \
	jq \
	jwt-cli \
	k9s \
	kotlin \
	kubectl \
	kubectx \
	liquibase \
	make \
	maven \
	ncdu \
	neovim \
	node \
	node@22 \
	pnpm \
	pyenv \
	python \
	tig \
	whatsapp

# Zentrale Clean-Definitionen (einfach erweiterbar)
CLEAN_FILES := \
	$(HOME)/.calendar \
	$(HOME)/.lesshst
CLEAN_DIRS := \
	$(HOME)/.cache \
	$(HOME)/.keychain \
	$(HOME)/.local

# Hilfs-Makros
define brew_for_each_package
	@set -e; \
	for pkg in $(BREW_PACKAGES); do \
		echo "==> $(1) $$pkg"; \
		$(BREW) $(2) $$pkg; \
	done
endef

# Renaming/Consistency: einheitlicher Name (Bugfix)
define run_in_subdirs
	@set -e; \
	for d in */; do \
		if [ -d "$$d" ]; then \
			$(MAKE) -C "$$d" $(1); \
		fi; \
	done
endef

.PHONY: \
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

brew-update:
	$(BREW) update

brew-install-packages:
	$(call brew_for_each_package,Installing,install)

brew-uninstall-packages:
	$(call brew_for_each_package,Uninstalling,uninstall --force)

brew-cleanup:
	$(BREW) autoremove

brew-post-install:
	$(BREW) doctor
	$(BREW) analytics off

brew-install: | \
	brew-update \
	brew-install-packages \
	brew-cleanup \
	brew-post-install

brew-outdated:
	$(BREW) outdated

brew-perform-upgrade:
	$(BREW) upgrade

brew-upgrade: | \
	brew-update \
	brew-outdated \
	brew-perform-upgrade \
	brew-cleanup

install: | brew-install
	$(call run_in_subdirs,install)

upgrade: | brew-upgrade
	$(call run_in_subdirs,upgrade)

clean: | brew-uninstall-packages
	rm -f $(CLEAN_FILES)
	rm -rf $(CLEAN_DIRS)
	$(call run_in_subdirs,clean)
