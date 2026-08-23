include ../make/common.mk

GIT_DIR_SYMLINK := $(HOME)/.git
GIT_CONFIG_FILE := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE := $(HOME)/.gitconfig.local
GIT_IGNORE_FILE := $(HOME)/.gitignore
GIT_PROJECTS_DIR := $(ROOT_DIR)/git
GITATTR_REPO_DIR := $(GIT_PROJECTS_DIR)/GitAttributesRepository
GITIGNORE_REPO_DIR := $(GIT_PROJECTS_DIR)/GitIgnoreRepository
REPO_DIRS := $(GITATTR_REPO_DIR) $(GITIGNORE_REPO_DIR)

.PHONY: ensure-git install plugin upgrade clean

ensure-git:
	@$(call ensure_cmd,git)

$(GIT_DIR_SYMLINK):
	$(symlink) $(ROOT_DIR) $@

$(GITATTR_REPO_DIR):
	$(call clone_or_update_repo,alexkaratarakis/gitattributes,$(GIT_PROJECTS_DIR),GitAttributesRepository)

$(GITIGNORE_REPO_DIR):
	$(call clone_or_update_repo,github/gitignore,$(GIT_PROJECTS_DIR),GitIgnoreRepository)

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
