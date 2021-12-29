.PHONY: clean
clean:
	rm -f ${HOME}/.calendar
	#
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f clean; \
	    fi \
	done

.PHONY: install
install:
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f install; \
	    fi \
	done
	#
	chmod -R go= ${HOME}
	chown -R $(shell id -u):$(shell id -g) ${HOME}

.PHONY: default
default: | clean install
