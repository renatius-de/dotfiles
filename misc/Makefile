ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ASDF_CONFIG = $(HOME)/.asdfrc
DIR_ASDF = $(HOME)/.asdf
PLUGINS = $(DIR_ASDF)/plugins

COMMAND_ASDF = $(DIR_ASDF)/bin/asdf

DENO = $(PLUGINS)/deno
EDITORCONFIG_CHECKER = $(PLUGINS)/editorconfig-checker
GRADLE = $(PLUGINS)/gradle
HELM = $(PLUGINS)/helm
JAVA = $(PLUGINS)/java
JQ = $(PLUGINS)/jq
K9S = $(PLUGINS)/k9s
KOTLIN = $(PLUGINS)/kotlin
KUBECTL = $(PLUGINS)/kubectl
KUBECTX = $(PLUGINS)/kubectx
KUBELOGIN = $(PLUGINS)/kubelogin
MAVEN = $(PLUGINS)/maven
NEOVIM = $(PLUGINS)/neovim
NODEJS = $(PLUGINS)/nodejs
PYTHON = $(PLUGINS)/python
SBT = $(PLUGINS)/sbt
SCALA = $(PLUGINS)/scala
TERRAFORM = $(PLUGINS)/terraform

$(ASDF_CONFIG):
	ln -snf $(ROOT_DIR)/asdfrc $(ASDF_CONFIG)

$(DIR_ASDF): | $(ASDF_CONFIG)
	git clone https://github.com/asdf-vm/asdf.git $(DIR_ASDF)

$(EDITORCONFIG_CHECKER): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add editorconfig-checker
	$(COMMAND_ASDF) install editorconfig-checker latest
	$(COMMAND_ASDF) global editorconfig-checker latest

$(DENO): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add deno
	$(COMMAND_ASDF) install deno latest
	$(COMMAND_ASDF) global deno latest

$(GRADLE): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add gradle
	$(COMMAND_ASDF) install gradle latest
	$(COMMAND_ASDF) global gradle latest

$(HELM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add helm
	$(COMMAND_ASDF) install helm latest
	$(COMMAND_ASDF) global helm latest

$(JAVA): $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add java
	$(COMMAND_ASDF) install java latest:corretto-8
	$(COMMAND_ASDF) install java latest:corretto-11
	$(COMMAND_ASDF) install java latest:corretto-17
	$(COMMAND_ASDF) install java latest:corretto-21
	$(COMMAND_ASDF) global java latest:corretto-21

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

$(PYTHON): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add python
	$(COMMAND_ASDF) install python latest
	$(COMMAND_ASDF) global python latest

$(SBT): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add sbt
	$(COMMAND_ASDF) install sbt latest
	$(COMMAND_ASDF) global sbt latest

$(SCALA): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add scala
	$(COMMAND_ASDF) install scala latest
	$(COMMAND_ASDF) global scala latest

$(TERRAFORM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add terraform
	$(COMMAND_ASDF) install terraform latest
	$(COMMAND_ASDF) global terraform latest

.PHONY: asdf
asdf: | \
	$(DENO) \
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
    $(SBT) \
    $(SCALA) \
    $(TERRAFORM)

.PHONY: clean
clean:
	rm -fr $(HOME)/.asdf
	rm -f $(HOME)/.asdfrc
	rm -fr $(HOME)/.tool-versions
	#
	rm -fr $(ASDF_CONFIG)
	rm -fr $(DIR_ASDF)
	#
	rm -fr $(HOME)/.sdkman
	#
	rm -rf $(HOME)/.nvm
	rm -rf $(HOME)/.npm

.PHONY: install
install: | asdf

.PHONY: upgrade
upgrade: | install
	$(COMMAND_ASDF) update
	$(COMMAND_ASDF) plugin update --all
