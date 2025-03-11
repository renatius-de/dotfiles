.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ASDF_CONFIG = $(HOME)/.asdfrc
INSTALLS = $(HOME)/.asdf/installs

COMMAND_ASDF = /opt/homebrew/bin/asdf

CHEAT = $(INSTALLS)/cheat
FLYWAY = $(INSTALLS)/flyway
JAVA = $(INSTALLS)/java
JQ = $(INSTALLS)/jq
K9S = $(INSTALLS)/k9s
KOTLIN = $(INSTALLS)/kotlin
KUBE_CTL = $(INSTALLS)/kubectl
KUBE_CTX = $(INSTALLS)/kubectx
LIQUIBASE = $(INSTALLS)/liquibase
MAVEN = $(INSTALLS)/maven
NEOVIM = $(INSTALLS)/neovim
NODEJS = $(INSTALLS)/nodejs
PNPM = $(INSTALLS)/pnpm

$(ASDF_CONFIG):
	ln -snf $(ROOT_DIR)/asdfrc $(ASDF_CONFIG)

$(CHEAT): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add cheat

cheat: | $(CHEAT)
	$(COMMAND_ASDF) install cheat latest
	$(COMMAND_ASDF) set --home cheat latest

$(FLYWAY): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add flyway

flyway: | $(FLYWAY)
	$(COMMAND_ASDF) install flyway latest
	$(COMMAND_ASDF) set --home flyway latest

$(JAVA): |  $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add java

java: | $(JAVA)
	$(COMMAND_ASDF) install java latest:corretto
	$(COMMAND_ASDF) set --home java latest:corretto

$(JAVA)/corretto-21: | $(JAVA)

java-21: | $(JAVA)/corretto-21
	$(COMMAND_ASDF) install java latest:corretto-21
	$(COMMAND_ASDF) set --home java latest:corretto-21

$(JAVA)/corretto-17: | $(JAVA)

java-17: | $(JAVA)/corretto-17
	$(COMMAND_ASDF) install java latest:corretto-17
	$(COMMAND_ASDF) set --home java latest:corretto-17

$(JQ): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add jq

jq: | $(JQ)
	$(COMMAND_ASDF) install jq latest
	$(COMMAND_ASDF) set --home jq latest

$(K9S): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add k9s

k9s: | $(K9S)
	$(COMMAND_ASDF) install k9s latest
	$(COMMAND_ASDF) set --home k9s latest

$(KOTLIN): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add kotlin

kotlin: | $(KOTLIN)
	$(COMMAND_ASDF) install kotlin latest
	$(COMMAND_ASDF) set --home kotlin latest

$(KUBE_CTL): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add kubectl

kubectl: | $(KUBE_CTL)
	$(COMMAND_ASDF) install kubectl latest
	$(COMMAND_ASDF) set --home kubectl latest

$(KUBE_CTX): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add kubectx

kubectx: | $(KUBE_CTX)
	$(COMMAND_ASDF) install kubectx latest
	$(COMMAND_ASDF) set --home kubectx latest

$(LIQUIBASE): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add liquibase

liquibase: | $(LIQUIBASE)
	$(COMMAND_ASDF) install liquibase latest
	$(COMMAND_ASDF) set --home liquibase latest

$(MAVEN): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add maven

maven: | $(MAVEN)
	$(COMMAND_ASDF) install maven latest
	$(COMMAND_ASDF) set --home maven latest

$(NEOVIM): | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin add neovim

neovim: | $(NEOVIM)
	$(COMMAND_ASDF) install neovim stable
	$(COMMAND_ASDF) set --home neovim stable

$(NODEJS): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add nodejs

nodejs: | $(NODEJS)
	$(COMMAND_ASDF) cmd nodejs update-nodebuild
	$(COMMAND_ASDF) install nodejs $(shell $(COMMAND_ASDF) cmd nodejs resolve lts --latest-available)
	$(COMMAND_ASDF) set --home nodejs $(shell $(COMMAND_ASDF) cmd nodejs resolve lts --latest-available)

$(PNPM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add pnpm

pnpm: | $(PNPM)
	$(COMMAND_ASDF) install pnpm latest
	$(COMMAND_ASDF) set --home pnpm latest

.PHONY: install
install: | \
	cheat \
	flyway \
	java \
	java-17 \
	java-21 \
	jq \
	k9s \
	kotlin \
	kubectl \
	kubectx \
	liquibase \
	maven \
	neovim \
	nodejs \
	pnpm \
	#

asdf_upgrade: | $(ASDF_CONFIG)
	$(COMMAND_ASDF) plugin update --all

.PHONY: upgrade
upgrade: | \
	asdf_upgrade \
	install

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
