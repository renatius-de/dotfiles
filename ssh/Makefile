include ../make/common.mk

SSH_DIR := $(HOME)/.ssh
SSH_CONTROL_DIR := $(SSH_DIR)/control
SSH_CONFIG := $(SSH_DIR)/config
SSH_CONFIG_LOCAL := $(SSH_DIR)/config.local
SSH_KEYS_DIR := $(SSH_DIR)/keys
SSH_CONFIG_SOURCE := $(ROOT_DIR)/config

.PHONY: install upgrade clean init-ssh

$(SSH_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(SSH_CONTROL_DIR): | $(SSH_DIR)
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }
	@chmod 700 "$@" || { printf "ERROR: target [install] failed while securing permissions on %s\n" "$@" >&2; exit 1; }
	@printf "✅ Ready: [%s]\n" "$@"

$(SSH_KEYS_DIR): | $(SSH_DIR)
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }
	@printf "✅ Ready: [%s]\n" "$@"

$(SSH_CONFIG_LOCAL): | $(SSH_KEYS_DIR)
	@printf "==> Creating SSH local config [%s]\n" "$@"
	@$(call create_local_file,$@) || { $(call fail_target,install); }
	@printf "✅ Ready: [%s]\n" "$@"

$(SSH_CONFIG): | $(SSH_DIR)
	@printf "==> Installing SSH config from [%s] to [%s]\n" "$(SSH_CONFIG_SOURCE)" "$@"
	@$(call ensure_dir,$(dir $@)) || { $(call fail_target,install); }
	@$(COPY_FILE) "$(SSH_CONFIG_SOURCE)" "$@" || { printf "ERROR: target [install] failed while copying %s to %s\n" "$(SSH_CONFIG_SOURCE)" "$@" >&2; exit 1; }
	@printf "✅ Installed SSH config to [%s]\n" "$@"

init-ssh: $(SSH_CONTROL_DIR)
	@printf "==> Starting target [init-ssh]...\n"
	@printf "✅ Finished target [init-ssh]\n"

install: init-ssh $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

upgrade: install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_F) "$(SSH_CONFIG)" "$(SSH_CONFIG_LOCAL)" || { $(call fail_target,clean); }
	@$(RM_RF) "$(SSH_CONTROL_DIR)" "$(SSH_KEYS_DIR)" || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"
