include ../make/common.mk

GIT_DIR_SYMLINK := $(HOME)/.git
GIT_CONFIG_FILE := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE := $(HOME)/.gitconfig.local
GIT_IGNORE_FILE := $(HOME)/.gitignore
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

.PHONY: ensure-git install plugin upgrade clean

ensure-git:
	@$(call ensure_cmd,git)

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

$(GIT_IGNORE_FILE):
	$(symlink) $(ROOT_DIR)/ignore $@

plugin: ensure-git $(REPO_DIRS)

install: $(GIT_DIR_SYMLINK) $(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) $(GIT_IGNORE_FILE) plugin

upgrade: install

clean:
	@$(RM_F) $(HOME)/.git_template $(GIT_IGNORE_FILE) $(HOME)/.tig_history $(GIT_CONFIG_FILE) $(GIT_DIR_SYMLINK)
	@$(RM_RF) $(REPO_DIRS)
