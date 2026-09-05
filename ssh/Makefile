include ../make/common.mk

SSH_DIR := $(HOME)/.ssh
SSH_CONTROL_DIR := $(SSH_DIR)/control
SSH_CONFIG := $(SSH_DIR)/config
SSH_CONFIG_LOCAL := $(SSH_DIR)/config.local
SSH_KEYS_DIR := $(SSH_DIR)/keys
SSH_CONFIG_SOURCE := $(ROOT_DIR)/ssh/config

.PHONY: install upgrade clean init-ssh $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)

$(SSH_DIR):
	$(call ensure_directory,$@,install)

$(SSH_CONTROL_DIR): | $(SSH_DIR)
	$(call ensure_directory,$@,install)
	@chmod 700 "$@" || { printf "ERROR: target [install] failed while securing permissions on %s\n" "$@" >&2; exit 1; }
	@printf "✅ Ready: [%s]\n" "$@"

$(SSH_KEYS_DIR): | $(SSH_DIR)
	$(call ensure_directory,$@,install)
	@printf "✅ Ready: [%s]\n" "$@"

$(SSH_CONFIG_LOCAL): | $(SSH_KEYS_DIR)
	@printf "==> Creating SSH local config [%s]\n" "$@"
	@$(call create_local_file,$@) || { $(call fail_target,install); }
	@printf "✅ Ready: [%s]\n" "$@"

$(SSH_CONFIG): | $(SSH_DIR)
	$(call link_file_to_target,install,$@,$(SSH_CONFIG_SOURCE))

init-ssh: $(SSH_CONTROL_DIR)
	$(call target_start,init-ssh)
	$(call target_end,init-ssh)

install: init-ssh $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)
	$(call target_start,install)
	$(call target_end,install)

upgrade: install
	$(call target_start,upgrade)
	$(call target_end,upgrade)

clean:
	$(call target_start,clean)
	@$(RM_F) "$(SSH_CONFIG)" "$(SSH_CONFIG_LOCAL)" || { $(call fail_target,clean); }
	@$(RM_RF) "$(SSH_CONTROL_DIR)" "$(SSH_KEYS_DIR)" || { $(call fail_target,clean); }
	$(call target_end,clean)
