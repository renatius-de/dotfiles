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

BREW := $(shell command -v brew 2>/dev/null \
	|| command -v /opt/homebrew/bin/brew 2>/dev/null \
	|| command -v /usr/local/bin/brew 2>/dev/null \
	|| echo)

define ensure_brew
	test -n "$(BREW)" && test -x "$(BREW)" || { \
		printf "ERROR: target [brew-ensure] failed because Homebrew is not installed. Please install it from https://brew.sh\n" >&2; \
		exit 1; \
	}
endef

## Ensure a Make variable is set; emits a make-level error if not.
define ensure_var
	$(if $(strip $(value $(1))),,$(error REQUIRED: variable '$(1)' is not set in Makefile [$(MAKEFILE_BASE)]))
endef

LINK := ln -snf
MKDIR := install -d -m 0700
INSTALL_FILE := install -m 0600
RM_F := rm -f
RM_RF := rm -rf
DOWNLOAD := curl --fail --location --silent --show-error \
  --retry 3 --retry-delay 2 --retry-all-errors --max-time 20

define fail_target
	printf "ERROR: target [%s] failed in Makefile [%s]\n" "$(1)" "$(MAKEFILE_BASE)" >&2; \
	exit 1
endef

define run_cmd
	set -o pipefail; $(1) || { \
		printf "ERROR: target [%s] failed in Makefile [%s] while running command: %s\n" \
			"$(2)" "$(MAKEFILE_BASE)" "$(1)" >&2; \
		exit 1; \
	}
endef

define ensure_cmd
	command -v $(1) >/dev/null 2>&1 || { \
		printf "ERROR: target [%s] failed because command '%s' is not available in Makefile [%s]\n" \
			"$(2)" "$(1)" "$(MAKEFILE_BASE)" >&2; \
		exit 1; \
	}
endef

define ensure_dir
	$(call run_cmd,$(MKDIR) $(1),ensure_dir)
endef

define symlink
	$(call run_cmd,$(LINK) $(1) $(2),symlink)
endef

define clone_or_update_repo
	name=$$(basename $(1)); \
	if [ -n "$(3)" ]; then dest="$(3)"; else dest="$$name"; fi; \
	dir=$(2)/$$dest; \
	if [ ! -d "$$dir" ]; then \
		$(call run_cmd,git clone --depth=1 "https://github.com/$(1).git" "$$dir",clone_or_update_repo); \
	else \
		git -C "$$dir" pull --ff-only >/dev/null \
			|| { printf "ERROR: target [clone_or_update_repo] failed while updating %s in %s\n" "$(1)" "$$dir" >&2; exit 1; }; \
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
	@printf "==> Starting target [help]...\n"
	@cd "$(ROOT_DIR)" && $(MAKE) help
	@printf "✅ Finished target [help]\n"
endif
