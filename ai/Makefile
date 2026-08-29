include ../make/common.mk

COPILOT_DIR := $(HOME)/.copilot
COPILOT_INSTRUCTIONS_DIR := $(COPILOT_DIR)/instructions
CLAUDE_DIR := $(HOME)/.claude
CLAUDE_RULES_DIR := $(CLAUDE_DIR)/rules
AI_INSTRUCTION_FILES := $(wildcard $(ROOT_DIR)/ai/*.instructions.md)

.PHONY: install install-rules link clean upgrade

$(COPILOT_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(CLAUDE_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(CLAUDE_RULES_DIR): | $(CLAUDE_DIR)
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

install-rules: | $(COPILOT_INSTRUCTIONS_DIR) $(CLAUDE_RULES_DIR)
	@printf "==> Starting target [install-rules]...\n"
	@for src in $(AI_INSTRUCTION_FILES); do \
		real_src="$$(realpath "$$src")"; \
		copilot_target="$(COPILOT_INSTRUCTIONS_DIR)/$$(basename "$$src")"; \
		claude_target="$(CLAUDE_RULES_DIR)/$$(basename "$$src")"; \
		$(call symlink,$$real_src,$$copilot_target); \
		$(call symlink,$$real_src,$$claude_target); \
	done
	@printf "✅ Finished target [install-rules]\n"

link: install-rules

install: install-rules
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@for src in $(AI_INSTRUCTION_FILES); do \
		$(RM_F) "$(COPILOT_INSTRUCTIONS_DIR)/$$(basename "$$src")" "$(CLAUDE_RULES_DIR)/$$(basename "$$src")" || { $(call fail_target,clean); }; \
	done
	@$(RM_RF) "$(COPILOT_INSTRUCTIONS_DIR)" "$(CLAUDE_RULES_DIR)" || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"

upgrade: | install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"
