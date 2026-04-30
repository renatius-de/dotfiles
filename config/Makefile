.DEFAULT_GOAL := install
.DELETE_ON_ERROR:

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CONFIG_DIR := $(HOME)/.config
SPRING_BOOT_SOURCE := $(ROOT_DIR)/spring-boot
SPRING_BOOT_CONFIG_LINK := $(CONFIG_DIR)/spring-boot

DIR_MODE := 0700
INSTALL_DIR := install -d -m $(DIR_MODE)
LINK_DIR := ln -snf

.PHONY: install upgrade clean

$(CONFIG_DIR):
	$(INSTALL_DIR) $@

$(SPRING_BOOT_CONFIG_LINK): | $(CONFIG_DIR)
	$(LINK_DIR) $(SPRING_BOOT_SOURCE) $@

install: $(SPRING_BOOT_CONFIG_LINK)

upgrade: install

clean:
	rm -f $(SPRING_BOOT_CONFIG_LINK)
