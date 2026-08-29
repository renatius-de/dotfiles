include ../make/common.mk

COPILOT_DIR := $(HOME)/.copilot
COPILOT_INSTRUCTIONS_DIR := $(COPILOT_DIR)/instructions
COPILOT_INSTRUCTIONS_FILE := $(COPILOT_INSTRUCTIONS_DIR)/global-copilot-instructions.md
SOURCE_INSTRUCTIONS_FILE := $(ROOT_DIR)/ai/global-copilot-instructions.md

.PHONY: install link clean upgrade

$(COPILOT_DIR):
	@$(call ensure_dir,$@)

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	@$(call ensure_dir,$@)

$(COPILOT_INSTRUCTIONS_FILE): | $(COPILOT_INSTRUCTIONS_DIR)
	@$(call symlink,$(SOURCE_INSTRUCTIONS_FILE),$@)

install: | $(COPILOT_INSTRUCTIONS_FILE)

clean:
	@$(RM_F) $(COPILOT_INSTRUCTIONS_FILE)

upgrade: | install
