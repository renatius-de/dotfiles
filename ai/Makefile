include ../make/common.mk

COPILOT_DIR := $(HOME)/.copilot
COPILOT_INSTRUCTIONS_DIR := $(COPILOT_DIR)/instructions
COPILOT_INSTRUCTIONS_FILE := $(COPILOT_INSTRUCTIONS_DIR)/global-copilot-instructions.md
SOURCE_INSTRUCTIONS_FILE := $(ROOT_DIR)/ai/global-copilot-instructions.md

.PHONY: install link clean upgrade

$(COPILOT_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install); }

$(COPILOT_INSTRUCTIONS_FILE): | $(COPILOT_INSTRUCTIONS_DIR)
	@printf "==> Linking Copilot instructions from [%s] to [%s]\n" "$(SOURCE_INSTRUCTIONS_FILE)" "$@"
	@$(LINK) "$(SOURCE_INSTRUCTIONS_FILE)" "$@" || { printf "ERROR: target [install] failed while linking %s to %s\n" "$(SOURCE_INSTRUCTIONS_FILE)" "$@" >&2; exit 1; }
	@printf "✅ Linked Copilot instructions to [%s]\n" "$@"

install: | $(COPILOT_INSTRUCTIONS_FILE)
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_F) $(COPILOT_INSTRUCTIONS_FILE) || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"

upgrade: | install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"
