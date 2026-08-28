include ../make/common.mk

COPILOT_DIR := $(HOME)/.copilot
COPILOT_INSTRUCTIONS_DIR := $(COPILOT_DIR)/instructions
COPILOT_INSTRUCTIONS_FILE := $(COPILOT_INSTRUCTIONS_DIR)/global-copilot-instructions.md
SOURCE_INSTRUCTIONS_FILE := $(ROOT_DIR)/copilot/global-copilot-instructions.md

.PHONY: install link clean

$(COPILOT_DIR):
	@$(call ensure_dir,$@)

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	@$(call ensure_dir,$@)

$(COPILOT_INSTRUCTIONS_FILE): | $(COPILOT_INSTRUCTIONS_DIR)
	@$(call symlink,$(SOURCE_INSTRUCTIONS_FILE),$@)

install: link

link: $(COPILOT_INSTRUCTIONS_FILE)
	@printf "✓ Copilot instructions linked to %s\n" "$(COPILOT_INSTRUCTIONS_FILE)"

clean:
	@$(RM_F) $(COPILOT_INSTRUCTIONS_FILE)
