include ../make/common.mk

SPRING_BOOT_SOURCE := $(ROOT_DIR)/spring-boot
SPRING_BOOT_CONFIG_TARGET := $(HOME)/.config/spring-boot
CONFIG_DIR := $(HOME)/.config

.PHONY: install upgrade clean

$(CONFIG_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(SPRING_BOOT_CONFIG_TARGET): | $(CONFIG_DIR)
	@printf "==> Installing Spring Boot config into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install); }
	@$(COPY_TREE) "$(SPRING_BOOT_SOURCE)" "$@" || { printf "ERROR: target [install] failed while copying %s to %s\n" "$(SPRING_BOOT_SOURCE)" "$@" >&2; exit 1; }
	@printf "✅ Installed Spring Boot config into [%s]\n" "$@"

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
