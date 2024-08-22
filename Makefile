.DEFAULT_GOAL := install

.PHONY: install
install:
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f install; \
	    fi \
	done

.PHONY: upgrade
upgrade:
	@for f in $$(ls -d *); do \
	    if [ -d $$f ]; then \
		$(MAKE) -C $$f upgrade; \
	    fi \
	done

.PHONY: clean
clean:
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
