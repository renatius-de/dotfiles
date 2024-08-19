ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ASDF_CONFIG = $(HOME)/.asdfrc
DIR_ASDF = $(HOME)/.asdf
INSTALLS = $(DIR_ASDF)/installs

COMMAND_ASDF = $(DIR_ASDF)/bin/asdf

ALIAS = $(INSTALLS)/alias
CHEAT = $(INSTALLS)/cheat
GRADLE = $(INSTALLS)/gradle
HELM = $(INSTALLS)/helm
JAVA = $(INSTALLS)/java
JQ = $(INSTALLS)/jq
K9S = $(INSTALLS)/k9s
KOTLIN = $(INSTALLS)/kotlin
KUBECTL = $(INSTALLS)/kubectl
KUBECTX = $(INSTALLS)/kubectx
KUBELOGIN = $(INSTALLS)/kubelogin
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
	$(COMMAND_ASDF) install alias latest
	$(COMMAND_ASDF) global alias latest

$(CHEAT): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add cheat
	$(COMMAND_ASDF) install cheat latest
	$(COMMAND_ASDF) global cheat latest

$(GRADLE): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add gradle
	$(COMMAND_ASDF) install gradle latest
	$(COMMAND_ASDF) global gradle latest

$(HELM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add helm
	$(COMMAND_ASDF) install helm latest
	$(COMMAND_ASDF) global helm latest

$(JAVA): | $(ALIAS) $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add java
	$(COMMAND_ASDF) install java latest:corretto
	$(COMMAND_ASDF) alias java --auto

$(JAVA)/corretto-17: | $(JAVA)
	$(COMMAND_ASDF) install java latest:corretto-17
	$(COMMAND_ASDF) alias java --auto

$(JAVA)/corretto-21: | $(JAVA)
	$(COMMAND_ASDF) install java latest:corretto-21
	$(COMMAND_ASDF) global java latest:corretto-21
	$(COMMAND_ASDF) alias java --auto

$(JQ): $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add jq
	$(COMMAND_ASDF) install jq latest
	$(COMMAND_ASDF) global jq latest

$(K9S): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add k9s
	$(COMMAND_ASDF) install k9s latest
	$(COMMAND_ASDF) global k9s latest

$(KOTLIN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kotlin
	$(COMMAND_ASDF) install kotlin latest
	$(COMMAND_ASDF) global kotlin latest

$(KUBECTL): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubectl
	$(COMMAND_ASDF) install kubectl latest
	$(COMMAND_ASDF) global kubectl latest

$(KUBECTX): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubectx
	$(COMMAND_ASDF) install kubectx latest
	$(COMMAND_ASDF) global kubectx latest

$(KUBELOGIN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubelogin
	$(COMMAND_ASDF) install kubelogin latest
	$(COMMAND_ASDF) global kubelogin latest

$(MAVEN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add maven
	$(COMMAND_ASDF) install maven latest
	$(COMMAND_ASDF) global maven latest

$(NEOVIM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add neovim
	$(COMMAND_ASDF) install neovim latest
	$(COMMAND_ASDF) global neovim latest

$(NODEJS): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add nodejs
	$(COMMAND_ASDF) install nodejs latest
	$(COMMAND_ASDF) global nodejs latest

$(PNPM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add pnpm
	$(COMMAND_ASDF) install pnpm latest
	$(COMMAND_ASDF) global pnpm latest

$(PYTHON): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add python
	$(COMMAND_ASDF) install python latest
	$(COMMAND_ASDF) global python latest

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

.PHONY: install
install: | \
	$(ALIAS) \
	$(CHEAT) \
	$(GRADLE) \
	$(HELM) \
	$(JAVA) \
	$(JQ) \
	$(K9S) \
	$(KOTLIN) \
	$(KUBECTL) \
	$(KUBECTX) \
	$(KUBELOGIN) \
	$(MAVEN) \
	$(NEOVIM) \
	$(NODEJS) \
	$(PNPM) \
	$(PYTHON) \
	$(JAVA)/corretto-17 \
	$(JAVA)/corretto-21 \
	#

.PHONY: upgrade
upgrade: | install
	$(COMMAND_ASDF) update
	$(COMMAND_ASDF) plugin update --all
