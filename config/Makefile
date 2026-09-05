include ../make/common.mk

SPRING_BOOT_SOURCE := $(abspath $(dir $(MAKEFILE_BASE)))/spring-boot
SPRING_BOOT_CONFIG_TARGET := $(HOME)/.config/spring-boot
CONFIG_DIR := $(HOME)/.config

.PHONY: install upgrade clean $(SPRING_BOOT_CONFIG_TARGET)

$(CONFIG_DIR):
	$(call ensure_directory,$@,install)

$(SPRING_BOOT_CONFIG_TARGET): | $(CONFIG_DIR)
	$(call link_tree_to_target,install,$@,$(SPRING_BOOT_SOURCE))

install: $(SPRING_BOOT_CONFIG_TARGET)
	$(call target_start,install)
	$(call target_end,install)

upgrade: install
	$(call target_start,upgrade)
	$(call target_end,upgrade)

clean:
	$(call target_start,clean)
	@$(RM_RF) "$(SPRING_BOOT_CONFIG_TARGET)" || { $(call fail_target,clean); }
	$(call target_end,clean)
