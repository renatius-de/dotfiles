.PHONY: clean
clean:
	rm -f ${HOME}/.calendar
	rm -fr ${HOME}/.rvm
	#
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f clean; \
	    fi \
	done

.PHONY: install
install: | ${HOME}/.rvm
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f install; \
	    fi \
	done
	#
	chmod -R go= ${HOME}
	chown -R $(shell id -u):$(shell id -g) ${HOME}

${HOME}/.rvm:
	gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s -- stable --ignore-dotfiles

.PHONY: default
default: | clean install
