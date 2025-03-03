.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

BREW_COMMAND = /opt/homebrew/bin/brew

brew_install:
	$(BREW_COMMAND) update
	$(BREW_COMMAND) install asdf
	$(BREW_COMMAND) install coreutils
	$(BREW_COMMAND) install --cask corretto
	$(BREW_COMMAND) install git
	$(BREW_COMMAND) install jq
	$(BREW_COMMAND) install jwt-cli
	$(BREW_COMMAND) install kubectl
	$(BREW_COMMAND) install kubectx
	$(BREW_COMMAND) install make
	$(BREW_COMMAND) install maven
	$(BREW_COMMAND) install neovim
	$(BREW_COMMAND) install node
	$(BREW_COMMAND) install pnpm
	$(BREW_COMMAND) install python
	#
	$(BREW_COMMAND) autoremove

brew_uninstall:
	$(BREW_COMMAND) uninstall --force --ignore-dependencies asdf
	$(BREW_COMMAND) uninstall --force --ignore-dependencies coreutils
	$(BREW_COMMAND) uninstall --force --ignore-dependencies --cask corretto
	$(BREW_COMMAND) uninstall --force --ignore-dependencies git
	$(BREW_COMMAND) uninstall --force --ignore-dependencies jq
	$(BREW_COMMAND) uninstall --force --ignore-dependencies jwt-cli
	$(BREW_COMMAND) uninstall --force --ignore-dependencies kubectl
	$(BREW_COMMAND) uninstall --force --ignore-dependencies kubectx
	$(BREW_COMMAND) uninstall --force --ignore-dependencies make
	$(BREW_COMMAND) uninstall --force --ignore-dependencies maven
	$(BREW_COMMAND) uninstall --force --ignore-dependencies neovim
	$(BREW_COMMAND) uninstall --force --ignore-dependencies node
	$(BREW_COMMAND) uninstall --force --ignore-dependencies pnpm
	$(BREW_COMMAND) uninstall --force --ignore-dependencies python
	#
	$(BREW_COMMAND) autoremove

brew_upgrade:
	$(BREW_COMMAND) update
	$(BREW_COMMAND) outdated
	$(BREW_COMMAND) upgrade
	#
	$(BREW_COMMAND) autoremove

.PHONY: install
install: | brew_install
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f install; \
	    fi \
	done

.PHONY: upgrade
upgrade: | brew_upgrade
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f upgrade; \
	    fi \
	done

.PHONY: clean
clean: | brew_uninstall
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
