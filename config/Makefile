include ../make/common.mk

SPRING_BOOT_SOURCE := $(ROOT_DIR)/spring-boot
SPRING_BOOT_CONFIG_LINK := $(HOME)/.config/spring-boot

.PHONY: install upgrade clean

$(HOME)/.config:
	$(MKDIR) $@

$(SPRING_BOOT_CONFIG_LINK): | $(HOME)/.config
	$(symlink) $(SPRING_BOOT_SOURCE) $@

install: $(SPRING_BOOT_CONFIG_LINK)

upgrade: install

clean:
	$(RM_F) $(SPRING_BOOT_CONFIG_LINK)
