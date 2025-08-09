.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

BREW_BIN := /opt/homebrew/bin/brew
BREW_PACKAGES := \
	bitwarden \
	corretto \
	corretto@17 \
	corretto@21 \
	curl \
	docker-desktop \
	flyway \
	git \
	gitbucket \
	gnupg \
	google-chrome \
	gradle \
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
	python \
	tig \
	whatsapp

define brew_run_on_packages
	@set -e; \
	for pkg in $(BREW_PACKAGES); do \
		echo "==> $(1) $$pkg"; \
		$(BREW_BIN) $(2) $$pkg; \
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
	upgrade

brew-update:
	$(BREW_BIN) update

brew-install-packages:
	$(call brew_run_on_packages,Installing,install)

brew-uninstall-packages:
	$(call brew_run_on_packages,Uninstalling,uninstall --force)

brew-cleanup:
	$(BREW_BIN) autoremove

brew-post-install:
	$(BREW_BIN) doctor
	$(BREW_BIN) analytics off

brew-install: | \
	brew-update \
	brew-install-packages \
	brew-cleanup \
	brew-post-install

brew-outdated:
	$(BREW_BIN) outdated

brew-perform-upgrade:
	$(BREW_BIN) upgrade

brew-upgrade: | \
	brew-update \
	brew-outdated \
	brew-perform-upgrade \
	brew-cleanup

install: | brew-install
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f install; \
	    fi; \
	done

upgrade: | brew-upgrade
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f upgrade; \
	    fi; \
	done

.PHONY: clean
clean: | brew-uninstall-packages
	rm -f $(HOME)/.calendar
	rm -f $(HOME)/.lesshst
	#
	rm -rf $(HOME)/.cache
	rm -rf $(HOME)/.keychain
	rm -rf $(HOME)/.local
	#
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f clean; \
	    fi \
	done
