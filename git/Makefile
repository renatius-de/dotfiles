include ../make/common.mk

GIT_CONFIG_FILE := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE := $(HOME)/.gitconfig.local
GIT_IGNORE_FILE := $(HOME)/.gitignore
GIT_PROJECTS_DIR := $(ROOT_DIR)/git
GITATTR_REPO_DIR := $(GIT_PROJECTS_DIR)/GitAttributesRepository
GITIGNORE_REPO_DIR := $(GIT_PROJECTS_DIR)/GitIgnoreRepository
REPO_DIRS := $(GITATTR_REPO_DIR) $(GITIGNORE_REPO_DIR)

.PHONY: ensure-git install plugin upgrade clean \
	$(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) $(GIT_IGNORE_FILE)

ensure-git:
	$(call target_start,ensure-git)
	@$(call ensure_cmd,git,ensure-git) || { $(call fail_target,ensure-git); }
	$(call target_end,ensure-git)

$(GITATTR_REPO_DIR):
	@printf "==> Ensuring repository [%s]\n" "GitAttributesRepository"
	@$(call clone_or_update_repo,alexkaratarakis/gitattributes,$(GIT_PROJECTS_DIR),GitAttributesRepository) || { $(call fail_target,plugin); }
	@printf "✅ Repository ready: [%s]\n" "GitAttributesRepository"

$(GITIGNORE_REPO_DIR):
	@printf "==> Ensuring repository [%s]\n" "GitIgnoreRepository"
	@$(call clone_or_update_repo,github/gitignore,$(GIT_PROJECTS_DIR),GitIgnoreRepository) || { $(call fail_target,plugin); }
	@printf "✅ Repository ready: [%s]\n" "GitIgnoreRepository"

$(GIT_CONFIG_FILE):
	$(call link_file_to_target,install,$@,$(GIT_PROJECTS_DIR)/config)

$(GIT_CONFIG_LOCAL_FILE):
	@printf "==> Creating local Git config file [%s]\n" "$@"
	@$(call create_local_file,$@) || { $(call fail_target,install); }
	@printf "✅ Local Git config ready: [%s]\n" "$@"

$(GIT_IGNORE_FILE):
	$(call link_file_to_target,install,$@,$(GIT_PROJECTS_DIR)/ignore)

plugin: ensure-git $(REPO_DIRS)
	$(call target_start,plugin)
	$(call target_end,plugin)

install: $(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) $(GIT_IGNORE_FILE) plugin
	$(call target_start,install)
	$(call target_end,install)

upgrade: install
	$(call target_start,upgrade)
	$(call target_end,upgrade)

clean:
	$(call target_start,clean)
	@$(RM_F) $(HOME)/.git_template $(GIT_IGNORE_FILE) $(HOME)/.tig_history $(GIT_CONFIG_FILE) || { $(call fail_target,clean); }
	@$(RM_RF) $(REPO_DIRS) || { $(call fail_target,clean); }
	$(call target_end,clean)
