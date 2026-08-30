include ../make/common.mk

COPILOT_DIR := $(HOME)/.copilot
COPILOT_INSTRUCTIONS_DIR := $(COPILOT_DIR)/instructions
CLAUDE_DIR := $(HOME)/.claude
CLAUDE_RULES_DIR := $(CLAUDE_DIR)/rules
AI_INSTRUCTIONS_DIR := $(ROOT_DIR)/ai/instructions

.PHONY: install install-rules clean upgrade

$(COPILOT_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	@printf "==> Installing AI instructions into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-rules); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }
	@$(COPY_TREE) "$(AI_INSTRUCTIONS_DIR)/." "$@/" || { $(call fail_target,install-rules); }

$(CLAUDE_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(CLAUDE_RULES_DIR): | $(CLAUDE_DIR)
	@printf "==> Installing Claude rules into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-rules); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }
	@$(COPY_TREE) "$(AI_INSTRUCTIONS_DIR)/." "$@/" || { $(call fail_target,install-rules); }

install-rules: | $(COPILOT_INSTRUCTIONS_DIR) $(CLAUDE_RULES_DIR)
	@printf "==> Starting target [install-rules]...\n"
	@printf "✅ Finished target [install-rules]\n"

install: install-rules
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_RF) "$(COPILOT_INSTRUCTIONS_DIR)" "$(CLAUDE_RULES_DIR)" || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"

upgrade: | install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"
