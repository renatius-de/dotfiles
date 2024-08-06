ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

ASDF_CONFIG = $(HOME)/.asdfrc
DIR_ASDF = $(HOME)/.asdf
PLUGINS = $(DIR_ASDF)/plugins

COMMAND_ASDF = $(DIR_ASDF)/bin/asdf

ALIAS = $(PLUGINS)/alias
GRADLE = $(PLUGINS)/gradle
HELM = $(PLUGINS)/helm
JAVA = $(PLUGINS)/java
JQ = $(PLUGINS)/jq
K9S = $(PLUGINS)/k9s
KOTLIN = $(PLUGINS)/kotlin
KUBECTL = $(PLUGINS)/kubectl
KUBECTX = $(PLUGINS)/kubectx
MAVEN = $(PLUGINS)/maven
NEOVIM = $(PLUGINS)/neovim
NODEJS = $(PLUGINS)/nodejs
PNPM = $(PLUGINS)/pnpm
PYTHON = $(PLUGINS)/python

$(ASDF_CONFIG):
	ln -snf $(ROOT_DIR)/asdfrc $(ASDF_CONFIG)

$(DIR_ASDF): | $(ASDF_CONFIG)
	git clone https://github.com/asdf-vm/asdf.git $(DIR_ASDF)

$(ALIAS): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add alias
	$(COMMAND_ASDF) install alias latest
	$(COMMAND_ASDF) global alias latest
	$(COMMAND_ASDF) alias alias --auto

$(GRADLE): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add gradle
	$(COMMAND_ASDF) install gradle latest
	$(COMMAND_ASDF) global gradle latest
	$(COMMAND_ASDF) alias gradle --auto

$(HELM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add helm
	$(COMMAND_ASDF) install helm latest
	$(COMMAND_ASDF) global helm latest
	$(COMMAND_ASDF) alias helm --auto

$(JAVA): | $(DIR_ASDF) $(ALIAS)
	$(COMMAND_ASDF) plugin add java
	$(COMMAND_ASDF) install java latest:corretto-17
	$(COMMAND_ASDF) install java latest:corretto-21
	$(COMMAND_ASDF) global java latest:corretto-21
	$(COMMAND_ASDF) alias java --auto
	$(COMMAND_ASDF) alias java 17 latest:corretto-17
	$(COMMAND_ASDF) alias java 21 latest:corretto-21

$(JQ): $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add jq
	$(COMMAND_ASDF) install jq latest
	$(COMMAND_ASDF) global jq latest
	$(COMMAND_ASDF) alias jq --auto

$(K9S): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add k9s
	$(COMMAND_ASDF) install k9s latest
	$(COMMAND_ASDF) global k9s latest
	$(COMMAND_ASDF) alias k9s --auto

$(KOTLIN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kotlin
	$(COMMAND_ASDF) install kotlin latest
	$(COMMAND_ASDF) global kotlin latest
	$(COMMAND_ASDF) alias kotlin --auto

$(KUBECTL): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubectl
	$(COMMAND_ASDF) install kubectl latest
	$(COMMAND_ASDF) global kubectl latest
	$(COMMAND_ASDF) alias kubectl --auto

$(KUBECTX): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add kubectx
	$(COMMAND_ASDF) install kubectx latest
	$(COMMAND_ASDF) global kubectx latest
	$(COMMAND_ASDF) alias kubectx --auto

$(MAVEN): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add maven
	$(COMMAND_ASDF) install maven latest
	$(COMMAND_ASDF) global maven latest
	$(COMMAND_ASDF) alias maven --auto

$(NEOVIM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add neovim
	$(COMMAND_ASDF) install neovim latest
	$(COMMAND_ASDF) global neovim latest
	$(COMMAND_ASDF) alias neovim --auto

$(NODEJS): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add nodejs
	$(COMMAND_ASDF) install nodejs latest
	$(COMMAND_ASDF) global nodejs latest
	$(COMMAND_ASDF) alias nodejs --auto

$(PNPM): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add pnpm
	$(COMMAND_ASDF) install pnpm latest
	$(COMMAND_ASDF) global pnpm latest
	$(COMMAND_ASDF) alias pnpm --auto

$(PYTHON): | $(DIR_ASDF)
	$(COMMAND_ASDF) plugin add python
	$(COMMAND_ASDF) install python latest
	$(COMMAND_ASDF) global python latest
	$(COMMAND_ASDF) alias python --auto

.PHONY: asdf
asdf: | \
	$(ALIAS) \
    $(GRADLE) \
    $(HELM) \
    $(JAVA) \
    $(JQ) \
    $(K9S) \
    $(KOTLIN) \
    $(KUBECTL) \
    $(KUBECTX) \
    $(MAVEN) \
    $(NEOVIM) \
    $(NODEJS) \
    $(PNPM) \
    $(PYTHON)

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
