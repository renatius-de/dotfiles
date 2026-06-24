include ../make/common.mk

SPRING_BOOT_SOURCE := $(ROOT_DIR)/spring-boot
SPRING_BOOT_CONFIG_LINK := $(HOME)/.config/spring-boot
CONFIG_DIR := $(HOME)/.config

.PHONY: install upgrade clean

$(CONFIG_DIR):
	@$(call ensure_dir,$@)

$(SPRING_BOOT_CONFIG_LINK): | $(CONFIG_DIR)
	@$(symlink) $(SPRING_BOOT_SOURCE) $@

install: $(SPRING_BOOT_CONFIG_LINK)

upgrade: install

clean:
	@$(RM_F) $(SPRING_BOOT_CONFIG_LINK)
