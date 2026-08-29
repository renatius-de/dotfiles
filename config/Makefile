include ../make/common.mk

SPRING_BOOT_SOURCE := $(ROOT_DIR)/spring-boot
SPRING_BOOT_CONFIG_LINK := $(HOME)/.config/spring-boot
CONFIG_DIR := $(HOME)/.config

.PHONY: install upgrade clean

$(CONFIG_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(SPRING_BOOT_CONFIG_LINK): | $(CONFIG_DIR)
	@printf "==> Linking Spring Boot config from [%s] to [%s]\n" "$(SPRING_BOOT_SOURCE)" "$@"
	@$(LINK) "$(SPRING_BOOT_SOURCE)" "$@" || { printf "ERROR: target [install] failed while linking %s to %s\n" "$(SPRING_BOOT_SOURCE)" "$@" >&2; exit 1; }
	@printf "✅ Linked Spring Boot config to [%s]\n" "$@"

install: $(SPRING_BOOT_CONFIG_LINK)
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

upgrade: install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_F) $(SPRING_BOOT_CONFIG_LINK) || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"
