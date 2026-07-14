.SHELLFLAGS := -e -u -o pipefail -c
.SILENT:
.ONESHELL:
SHELL := /bin/bash
MAKEFLAGS += --no-print-directory

MAKEFILE_BASE := $(abspath $(word 1,$(MAKEFILE_LIST)))
MAKEFILE_ROOT_DIR := $(abspath $(dir $(MAKEFILE_BASE)))
ROOT_DIR := $(abspath $(shell git -C "$(MAKEFILE_ROOT_DIR)" rev-parse --show-toplevel 2>/dev/null \
  || printf '%s' "$(MAKEFILE_ROOT_DIR)"))
BASE_MAKEFILE := $(abspath $(ROOT_DIR)/Makefile)
LINK := ln -snf
MKDIR := install -d -m 0700
INSTALL_FILE := install -m 0600
RM_F := rm -f
RM_RF := rm -rf
DOWNLOAD := curl --fail --location --silent --show-error \
  --retry 3 --retry-delay 2 --retry-all-errors --max-time 20

define fail
	@printf "FAILED: Target [%s] in Makefile [%s] failed\n" "$(1)" "$(MAKEFILE_BASE)" >&2
	@exit 1
endef

define run_cmd
	@set -o pipefail; $(1) || { \
		printf "FAILED: Target [%s] in Makefile [%s] failed with command: %s\n" \
			"$(2)" "$(MAKEFILE_BASE)" "$(1)" >&2; \
		exit 1; }
endef

define ensure_cmd
	@command -v $(1) >/dev/null 2>&1 || { \
		printf "FAILED: required command '%s' not found in Makefile [%s]\n" \
			"$(1)" "$(MAKEFILE_BASE)" >&2; \
		exit 1; }
endef

define ensure_dir
	$(call run_cmd,$(MKDIR) $(1),ensure_dir)
endef

define symlink
	$(call run_cmd,$(LINK) $(1) $(2),symlink)
endef

define clone_or_update_repo
	@name=$$(basename $(1)); \
	dir=$(2)/$$name; \
	if [ ! -d "$$dir" ]; then \
	  $(call run_cmd,git clone --depth=1 "https://github.com/$(1).git" "$$dir",clone_or_update_repo); \
	else \
	  git -C "$$dir" pull --ff-only >/dev/null \
	    || { printf "FAILED: update %s in %s\n" "$(1)" "$$dir" >&2; exit 1; }; \
	fi
endef

define create_local_file
	$(call run_cmd,[ -e "$(1)" ] || $(INSTALL_FILE) /dev/null "$(1)",create_local_file)
endef

ifeq ($(MAKEFILE_ROOT_DIR),$(ROOT_DIR))
  # Root Makefile defines the canonical help target.
else
  .PHONY: help

  help:
	@cd "$(ROOT_DIR)" && $(MAKE) help
endif
