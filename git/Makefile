include ../make/common.mk

GIT_DIR_SYMLINK := $(HOME)/.git
GIT_CONFIG_FILE := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE := $(HOME)/.gitconfig.local
GITATTR_REPO_DIR := $(ROOT_DIR)/GitAttributesRepository
GITIGNORE_REPO_DIR := $(ROOT_DIR)/GitIgnoreRepository
REPO_DIRS := $(GITATTR_REPO_DIR) $(GITIGNORE_REPO_DIR)

GIT_ATTRIBUTES_URL := https://github.com/alexkaratarakis/gitattributes.git
GIT_IGNORE_URL := https://github.com/github/gitignore.git

define clone_or_update_git_repo
	@if [ -d "$(2)" ]; then \
		git -C "$(2)" pull --ff-only >/dev/null 2>&1 || true; \
	else \
		git clone --quiet --depth=1 "$(1)" "$(2)"; \
	fi
endef

$(GIT_DIR_SYMLINK):
	$(symlink) $(ROOT_DIR) $@

$(GITATTR_REPO_DIR):
	$(call clone_or_update_git_repo,$(GIT_ATTRIBUTES_URL),$@)

$(GITIGNORE_REPO_DIR):
	$(call clone_or_update_git_repo,$(GIT_IGNORE_URL),$@)

$(GIT_CONFIG_FILE):
	$(symlink) $(ROOT_DIR)/config $@

$(GIT_CONFIG_LOCAL_FILE):
	$(call create_local_file,$@)

.PHONY: install upgrade plugin clean

plugin: $(REPO_DIRS)

install: $(GIT_DIR_SYMLINK) $(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) plugin

upgrade: install

clean:
	$(RM_F) $(HOME)/.git_template $(HOME)/.gitignore $(HOME)/.tig_history $(GIT_CONFIG_FILE) $(GIT_DIR_SYMLINK)
	$(RM_RF) $(REPO_DIRS)
