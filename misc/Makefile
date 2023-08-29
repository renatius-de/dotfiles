ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

SDKMAN_DIR = $(HOME)/.sdkman
SDKMAN_COMMAND = source $(SDKMAN_DIR)/bin/sdkman-init.sh && sdk
SDKMAN_CONFIG = $(SDKMAN_DIR)/etc/config

SDK_CANDIDATES = $(SDKMAN_DIR)/candidates
GRADLE = $(SDK_CANDIDATES)/gradle/current
JAVA = $(SDK_CANDIDATES)/java/current
KOTLIN = $(SDK_CANDIDATES)/kotlin/current
MAVEN = $(SDK_CANDIDATES)/maven/current
SBT = $(SDK_CANDIDATES)/sbt/current

NVM_DIR = $(HOME)/.nvm
NVM_COMMAND = source $(NVM_DIR)/nvm.sh && nvm

$(SDKMAN_DIR):
	curl --silent 'https://get.sdkman.io?rcupdate=false' | bash

$(SDKMAN_CONFIG): | $(SDKMAN_DIR)
	ln -snf $(ROOT_DIR)/sdkamnrc $(SDKMAN_CONFIG)

$(GRADLE): | $(SDKMAN_DIR)
	$(SDKMAN_COMMAND) install gradle

$(JAVA): | $(SDKMAN_DIR)
	$(SDKMAN_COMMAND) install java

$(KOTLIN): | $(SDKMAN_DIR)
	$(SDKMAN_COMMAND) install kotlin

$(MAVEN): | $(SDKMAN_DIR)
	$(SDKMAN_COMMAND) install maven

$(SBT): | $(SDKMAN_DIR)
	$(SDKMAN_COMMAND) install sbt

.PHONY: sdkman
sdkman: | $(SDKMAN_CONFIG) $(GRADLE) $(JAVA) $(KOTLIN) $(MAVEN) $(SBT)

$(NVM_DIR):
	curl --silent --output - https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

nodejs: $(NVM_DIR)
	$(NVM_COMMAND) install --lts --latest-npm --no-progress --default

.PHONY: nvm
nvm: | $(NVM_DIR) nodejs

.PHONY: clean
clean:
	rm -fr $(SDKMAN_DIR)

.PHONY: install
install: | nvm sdkman

.PHONY: upgrade
upgrade: | install
	$(NVM_COMMAND) install-latest-npm
	#
	$(SDKMAN_COMMAND) update
	$(SDKMAN_COMMAND) selfupdate
	$(SDKMAN_COMMAND) upgrade
