include ../make/common.mk

SSH_DIR := $(HOME)/.ssh
SSH_CONTROL_DIR := $(SSH_DIR)/control
SSH_CONFIG := $(SSH_DIR)/config
SSH_CONFIG_LOCAL := $(SSH_DIR)/config.local
SSH_KEYS_DIR := $(SSH_DIR)/keys
SSH_CONFIG_SOURCE := $(ROOT_DIR)/config

.PHONY: install upgrade clean init-ssh

$(SSH_DIR):
	$(MKDIR) $@

$(SSH_CONTROL_DIR): | $(SSH_DIR)
	$(MKDIR) "$@"
	@chmod 700 "$@"

$(SSH_KEYS_DIR): | $(SSH_DIR)
	$(MKDIR) $@

$(SSH_CONFIG_LOCAL): | $(SSH_KEYS_DIR)
	$(call create_local_file,$@)

$(SSH_CONFIG): | $(SSH_DIR)
	$(symlink) $(SSH_CONFIG_SOURCE) $@

init-ssh: $(SSH_CONTROL_DIR)

install: init-ssh $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)

upgrade: install

clean:
	@$(RM_F) $(SSH_CONFIG)
