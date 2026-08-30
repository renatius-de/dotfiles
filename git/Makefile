include ../make/common.mk

GIT_CONFIG_FILE := $(HOME)/.gitconfig
GIT_CONFIG_LOCAL_FILE := $(HOME)/.gitconfig.local
GIT_IGNORE_FILE := $(HOME)/.gitignore
GIT_PROJECTS_DIR := $(ROOT_DIR)/git
GITATTR_REPO_DIR := $(GIT_PROJECTS_DIR)/GitAttributesRepository
GITIGNORE_REPO_DIR := $(GIT_PROJECTS_DIR)/GitIgnoreRepository
REPO_DIRS := $(GITATTR_REPO_DIR) $(GITIGNORE_REPO_DIR)

.PHONY: ensure-git install plugin upgrade clean

ensure-git:
	@printf "==> Starting target [ensure-git]...\n"
	@$(call ensure_cmd,git,ensure-git) || { $(call fail_target,ensure-git); }
	@printf "✅ Finished target [ensure-git]\n"

$(GITATTR_REPO_DIR):
	@printf "==> Ensuring repository [%s]\n" "GitAttributesRepository"
	@$(call clone_or_update_repo,alexkaratarakis/gitattributes,$(GIT_PROJECTS_DIR),GitAttributesRepository) || { $(call fail_target,plugin); }
	@printf "✅ Repository ready: [%s]\n" "GitAttributesRepository"

$(GITIGNORE_REPO_DIR):
	@printf "==> Ensuring repository [%s]\n" "GitIgnoreRepository"
	@$(call clone_or_update_repo,github/gitignore,$(GIT_PROJECTS_DIR),GitIgnoreRepository) || { $(call fail_target,plugin); }
	@printf "✅ Repository ready: [%s]\n" "GitIgnoreRepository"

$(GIT_CONFIG_FILE):
	@printf "==> Installing Git config from [%s] to [%s]\n" "$(GIT_PROJECTS_DIR)/config" "$@"
	@$(call ensure_dir,$(dir $@)) || { $(call fail_target,install); }
	@$(COPY_FILE) "$(GIT_PROJECTS_DIR)/config" "$@" || { printf "ERROR: target [install] failed while copying %s to %s\n" "$(GIT_PROJECTS_DIR)/config" "$@" >&2; exit 1; }
	@printf "✅ Installed Git config to [%s]\n" "$@"

$(GIT_CONFIG_LOCAL_FILE):
	@printf "==> Creating local Git config file [%s]\n" "$@"
	@$(call create_local_file,$@) || { $(call fail_target,install); }
	@printf "✅ Local Git config ready: [%s]\n" "$@"

$(GIT_IGNORE_FILE):
	@printf "==> Installing Git ignore file from [%s] to [%s]\n" "$(GIT_PROJECTS_DIR)/ignore" "$@"
	@$(call ensure_dir,$(dir $@)) || { $(call fail_target,install); }
	@$(COPY_FILE) "$(GIT_PROJECTS_DIR)/ignore" "$@" || { printf "ERROR: target [install] failed while copying %s to %s\n" "$(GIT_PROJECTS_DIR)/ignore" "$@" >&2; exit 1; }
	@printf "✅ Installed Git ignore file to [%s]\n" "$@"

plugin: ensure-git $(REPO_DIRS)
	@printf "==> Starting target [plugin]...\n"
	@printf "✅ Finished target [plugin]\n"

install: $(GIT_CONFIG_FILE) $(GIT_CONFIG_LOCAL_FILE) $(GIT_IGNORE_FILE) plugin
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

upgrade: install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_F) $(HOME)/.git_template $(GIT_IGNORE_FILE) $(HOME)/.tig_history $(GIT_CONFIG_FILE) || { $(call fail_target,clean); }
	@$(RM_RF) $(REPO_DIRS) || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"
