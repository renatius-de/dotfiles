.SHELLFLAGS := -e -u -o pipefail -c
.SILENT:
.ONESHELL:
SHELL := /bin/bash

ROOT_DIR := $(abspath $(dir $(realpath $(word 1,$(MAKEFILE_LIST)))))

LINK := ln -snf
MKDIR := install -d -m 0700
INSTALL_FILE := install -m 0600
RM_F := rm -f
RM_RF := rm -rf
DOWNLOAD := curl --fail --location --silent --show-error --retry 3 --retry-delay 2 --retry-all-errors --max-time 20

define ensure_cmd
	@command -v $(1) >/dev/null 2>&1 || { printf "Error: missing command '%s'\n" "$(1)" >&2; exit 1; }
endef

define ensure_dir
	$(MKDIR) $(1)
endef

define symlink
	$(LINK) $(1) $(2)
endef

define clone_or_update_repo
	@name=$$(basename $(1)); \
	dir=$(2)/$$name; \
	if [ ! -d "$$dir" ]; then \
		git clone --depth=1 "https://github.com/$(1).git" "$$dir"; \
	else \
		git -C "$$dir" pull --ff-only >/dev/null 2>&1 || true; \
	fi
endef
