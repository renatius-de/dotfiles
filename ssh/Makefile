include ../make/common.mk

SSH_DIR := $(HOME)/.ssh
SSH_CONFIG := $(SSH_DIR)/config
SSH_CONFIG_LOCAL := $(SSH_DIR)/config.local
SSH_KEYS_DIR := $(SSH_DIR)/keys
SSH_CONFIG_SOURCE := $(ROOT_DIR)/config
FILE_MODE := 0600

.PHONY: install upgrade clean

$(SSH_DIR):
	$(MKDIR) $@

$(SSH_KEYS_DIR): | $(SSH_DIR)
	$(MKDIR) $@

$(SSH_CONFIG_LOCAL): | $(SSH_KEYS_DIR)
	@[ -e "$@" ] || $(INSTALL_FILE) $(FILE_MODE) /dev/null "$@"

$(SSH_CONFIG): | $(SSH_DIR)
	$(symlink) $(SSH_CONFIG_SOURCE) $@

install: $(SSH_CONFIG) $(SSH_CONFIG_LOCAL)

upgrade: install

clean:
	$(RM_F) $(SSH_CONFIG)
