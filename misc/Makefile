.DEFAULT_GOAL := install
.DELETE_ON_ERROR:
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ASDF_CONFIG = $(HOME)/.asdfrc
DIR_ASDF = $(HOME)/.asdf
INSTALLS = $(DIR_ASDF)/installs

COMMAND_ASDF = $(DIR_ASDF)/bin/asdf

ALIAS = $(INSTALLS)/alias
CHEAT = $(INSTALLS)/cheat
FLYWAY = $(INSTALLS)/flyway
GRADLE = $(INSTALLS)/gradle
HELM = $(INSTALLS)/helm
JAVA = $(INSTALLS)/java
JQ = $(INSTALLS)/jq
K9S = $(INSTALLS)/k9s
KOTLIN = $(INSTALLS)/kotlin
KUBECTL = $(INSTALLS)/kubectl
KUBECTX = $(INSTALLS)/kubectx
LIQUIBASE = $(INSTALLS)/liquibase
MAVEN = $(INSTALLS)/maven
NEOVIM = $(INSTALLS)/neovim
NODEJS = $(INSTALLS)/nodejs
PNPM = $(INSTALLS)/pnpm
PYTHON = $(INSTALLS)/python

$(ASDF_CONFIG):
	ln -snf $(ROOT_DIR)/asdfrc $(ASDF_CONFIG)

$(DIR_ASDF): | $(ASDF_CONFIG)
	git clone https://github.com/asdf-vm/asdf.git $(DIR_ASDF)

$(ALIAS): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add alias

alias: | $(ALIAS)
	$(COMMAND_ASDF) install alias latest
	$(COMMAND_ASDF) global alias latest

$(CHEAT): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add cheat

cheat: | $(CHEAT)
	$(COMMAND_ASDF) install cheat latest
	$(COMMAND_ASDF) global cheat latest

$(FLYWAY): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add flyway

flyway: | $(FLYWAY)
	$(COMMAND_ASDF) install flyway latest
	$(COMMAND_ASDF) global flyway latest

$(GRADLE): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add gradle

gradle: | $(GRADLE)
	$(COMMAND_ASDF) install gradle latest
	$(COMMAND_ASDF) global gradle latest

$(HELM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add helm

helm: | $(HELM)
	$(COMMAND_ASDF) install helm latest
	$(COMMAND_ASDF) global helm latest

$(JAVA): | $(ALIAS) $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add java

java: | $(JAVA)
	$(COMMAND_ASDF) install java latest:corretto
	$(COMMAND_ASDF) global java latest:corretto
	$(COMMAND_ASDF) alias java --auto

$(JAVA)/corretto-17: | $(JAVA)

java-17: | $(JAVA)/corretto-17
	$(COMMAND_ASDF) install java latest:corretto-17
	$(COMMAND_ASDF) alias java --auto

$(JAVA)/corretto-21: | $(JAVA)

java-21: | $(JAVA)/corretto-21
	$(COMMAND_ASDF) install java latest:corretto-21
	$(COMMAND_ASDF) global java latest:corretto-21
	$(COMMAND_ASDF) alias java --auto

$(JQ): $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add jq

jq: | $(JQ)
	$(COMMAND_ASDF) install jq latest
	$(COMMAND_ASDF) global jq latest

$(K9S): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add k9s

k9s: | $(K9S)
	$(COMMAND_ASDF) install k9s latest
	$(COMMAND_ASDF) global k9s latest

$(KOTLIN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kotlin

kotlin: |
	$(COMMAND_ASDF) install kotlin latest
	$(COMMAND_ASDF) global kotlin latest

$(KUBECTL): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubectl

kubectl: | $(KUBECTL)
	$(COMMAND_ASDF) install kubectl latest
	$(COMMAND_ASDF) global kubectl latest

$(KUBECTX): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubectx

kubectx: | $(KUBECTX)
	$(COMMAND_ASDF) install kubectx latest
	$(COMMAND_ASDF) global kubectx latest

$(LIQUIBASE): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add liquibase

liquibase: | $(LIQUIBASE)
	$(COMMAND_ASDF) install liquibase latest
	$(COMMAND_ASDF) global liquibase latest

$(MAVEN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add maven

maven: | $(MAVEN)
	$(COMMAND_ASDF) install maven latest
	$(COMMAND_ASDF) global maven latest

$(NEOVIM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add neovim

neovim: | $(NEOVIM)
	$(COMMAND_ASDF) install neovim stable
	$(COMMAND_ASDF) global neovim stable

$(NODEJS): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add nodejs

nodejs: | $(NODEJS)
	$(COMMAND_ASDF) install nodejs latest
	$(COMMAND_ASDF) global nodejs latest

$(PNPM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add pnpm

pnpm: | $(PNPM)
	$(COMMAND_ASDF) install pnpm latest
	$(COMMAND_ASDF) global pnpm latest

$(PYTHON): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add python

python: | $(PYTHON)
	$(COMMAND_ASDF) install python latest
	$(COMMAND_ASDF) global python latest

.PHONY: install
install: | \
	alias \
	cheat \
	flyway \
	gradle \
	helm \
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
	python \
	#

asdf_upgrade: | $(DIR_ASDF)
	$(COMMAND_ASDF) update
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
	rm -fr $(DIR_ASDF)
	#
	rm -fr $(HOME)/.config/cheat
	#
	rm -fr $(HOME)/.sdkman
	#
	rm -rf $(HOME)/.nvm
	rm -rf $(HOME)/.npm
