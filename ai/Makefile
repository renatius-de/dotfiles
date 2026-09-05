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

.PHONY: install install-rules install-skills clean upgrade \
	$(COPILOT_INSTRUCTIONS_DIR) $(COPILOT_SKILLS_DIR) \
	$(CLAUDE_RULES_DIR) $(CLAUDE_SKILLS_DIR) $(AGENTS_SKILLS_DIR)

$(COPILOT_DIR):
	$(call ensure_directory,$@,install-rules)

$(COPILOT_INSTRUCTIONS_DIR): | $(COPILOT_DIR)
	$(call link_tree_to_target,install-rules,$@,$(AI_INSTRUCTIONS_DIR))

$(COPILOT_SKILLS_DIR): | $(COPILOT_DIR)
	$(call link_tree_to_target,install-skills,$@,$(AI_SKILLS_DIR))

$(CLAUDE_DIR):
	$(call ensure_directory,$@,install-rules)

$(CLAUDE_RULES_DIR): | $(CLAUDE_DIR)
	$(call link_tree_to_target,install-rules,$@,$(AI_INSTRUCTIONS_DIR))

$(CLAUDE_SKILLS_DIR): | $(CLAUDE_DIR)
	$(call link_tree_to_target,install-skills,$@,$(AI_SKILLS_DIR))

$(AGENTS_DIR):
	$(call ensure_directory,$@,install-skills)

$(AGENTS_SKILLS_DIR): | $(AGENTS_DIR)
	$(call link_tree_to_target,install-skills,$@,$(AI_SKILLS_DIR))

install-rules: | $(COPILOT_INSTRUCTIONS_DIR) $(CLAUDE_RULES_DIR)
	$(call target_start,install-rules)
	$(call target_end,install-rules)

install-skills: | $(COPILOT_SKILLS_DIR) $(CLAUDE_SKILLS_DIR) $(AGENTS_SKILLS_DIR)
	$(call target_start,install-skills)
	$(call target_end,install-skills)

install: install-rules install-skills
	$(call target_start,install)
	$(call target_end,install)

clean:
	$(call target_start,clean)
	@$(RM_RF) "$(COPILOT_INSTRUCTIONS_DIR)" "$(COPILOT_SKILLS_DIR)" "$(CLAUDE_RULES_DIR)" "$(CLAUDE_SKILLS_DIR)" "$(AGENTS_SKILLS_DIR)" || { $(call fail_target,clean); }
	$(call target_end,clean)

upgrade: | install
	$(call target_start,upgrade)
	$(call target_end,upgrade)
