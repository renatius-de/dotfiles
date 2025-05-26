.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CERT_FILE = $(HOME)/dev/optadata/optadata-gruppe-ODA-DC1-CA.cer

.PHONY: install
install: | $(CERT_FILE)
ifneq ("$(wildcard $(CERT_FILE))","")
	sudo /Library/Java/JavaVirtualMachines/amazon-corretto-24.jdk/Contents/Home/bin/keytool -import -trustcacerts -alias opta_data-gruppe-certificate -file $(CERT_FILE) -cacerts -storepass changeit -noprompt
	sudo /Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home/bin/keytool -import -trustcacerts -alias opta_data-gruppe-certificate -file $(CERT_FILE) -cacerts -storepass changeit -noprompt
	sudo /Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/bin/keytool -import -trustcacerts -alias opta_data-gruppe-certificate -file $(CERT_FILE) -cacerts -storepass changeit -noprompt
endif

.PHONY: upgrade
upgrade:

.PHONY: clean
clean:
	rm -fr $(HOME)/.tool-versions
	#
	rm -fr $(ASDF_CONFIG)
	rm -fr $(HOME)/.asdf
	#
	rm -fr $(HOME)/.config/cheat
	#
	rm -fr $(HOME)/.sdkman
	#
	rm -rf $(HOME)/.nvm
	rm -rf $(HOME)/.npm
