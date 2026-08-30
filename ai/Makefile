include ../make/common.mk

COPILOT_DIR := $(HOME)/.copilot
COPILOT_INSTRUCTIONS_DIR := $(COPILOT_DIR)/instructions
COPILOT_SKILLS_DIR := $(COPILOT_DIR)/skills
CLAUDE_DIR := $(HOME)/.claude
CLAUDE_RULES_DIR := $(CLAUDE_DIR)/rules
CLAUDE_SKILLS_DIR := $(CLAUDE_DIR)/skills
AGENTS_DIR := $(HOME)/.agents
AGENTS_SKILLS_DIR := $(AGENTS_DIR)/skills
AI_INSTRUCTIONS_DIR := $(ROOT_DIR)/ai/instructions
AI_SKILLS_DIR := $(ROOT_DIR)/ai/skills

.PHONY: install install-rules install-skills clean upgrade

$(COPILOT_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	@printf "==> Installing AI instructions into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-rules); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }
	@$(COPY_TREE) "$(AI_INSTRUCTIONS_DIR)/." "$@/" || { $(call fail_target,install-rules); }

$(COPILOT_SKILLS_DIR): | $(COPILOT_DIR)
	@printf "==> Installing AI skills into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-skills); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-skills); }
	@$(COPY_TREE) "$(AI_SKILLS_DIR)/." "$@/" || { $(call fail_target,install-skills); }

$(CLAUDE_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }

$(CLAUDE_RULES_DIR): | $(CLAUDE_DIR)
	@printf "==> Installing Claude rules into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-rules); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-rules); }
	@$(COPY_TREE) "$(AI_INSTRUCTIONS_DIR)/." "$@/" || { $(call fail_target,install-rules); }

$(CLAUDE_SKILLS_DIR): | $(CLAUDE_DIR)
	@printf "==> Installing Claude skills into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-skills); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-skills); }
	@$(COPY_TREE) "$(AI_SKILLS_DIR)/." "$@/" || { $(call fail_target,install-skills); }

$(AGENTS_DIR):
	@printf "==> Ensuring directory [%s]\n" "$@"
	@$(call ensure_dir,$@) || { $(call fail_target,install-skills); }

$(AGENTS_SKILLS_DIR): | $(AGENTS_DIR)
	@printf "==> Installing agents skills into [%s]\n" "$@"
	@$(RM_RF) "$@" || { $(call fail_target,install-skills); }
	@$(call ensure_dir,$@) || { $(call fail_target,install-skills); }
	@$(COPY_TREE) "$(AI_SKILLS_DIR)/." "$@/" || { $(call fail_target,install-skills); }

install-rules: | $(COPILOT_INSTRUCTIONS_DIR) $(CLAUDE_RULES_DIR)
	@printf "==> Starting target [install-rules]...\n"
	@printf "✅ Finished target [install-rules]\n"

install-skills: | $(COPILOT_SKILLS_DIR) $(CLAUDE_SKILLS_DIR) $(AGENTS_SKILLS_DIR)
	@printf "==> Starting target [install-skills]...\n"
	@printf "✅ Finished target [install-skills]\n"

install: install-rules install-skills
	@printf "==> Starting target [install]...\n"
	@printf "✅ Finished target [install]\n"

clean:
	@printf "==> Starting target [clean]...\n"
	@$(RM_RF) "$(COPILOT_INSTRUCTIONS_DIR)" "$(COPILOT_SKILLS_DIR)" "$(CLAUDE_RULES_DIR)" "$(CLAUDE_SKILLS_DIR)" "$(AGENTS_SKILLS_DIR)" || { $(call fail_target,clean); }
	@printf "✅ Finished target [clean]\n"

upgrade: | install
	@printf "==> Starting target [upgrade]...\n"
	@printf "✅ Finished target [upgrade]\n"
