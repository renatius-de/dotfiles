include ../make/common.mk

SPRING_BOOT_SOURCE := $(abspath $(dir $(MAKEFILE_BASE)))/spring-boot
SPRING_BOOT_CONFIG_TARGET := $(HOME)/.config/spring-boot
CONFIG_DIR := $(HOME)/.config

.PHONY: install upgrade clean

$(CONFIG_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(SPRING_BOOT_CONFIG_TARGET): | $(CONFIG_DIR)
	$(call install_tree_to_target,install,$@,$(SPRING_BOOT_SOURCE))

install: $(SPRING_BOOT_CONFIG_TARGET)
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

upgrade: install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_RF) "$(SPRING_BOOT_CONFIG_TARGET)" || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"
