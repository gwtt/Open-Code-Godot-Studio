# README Enhancement Work Plan

## Overview

Enhance README.md and create README_CN.md to address 4 requirements:
1. Chinese translation (README_CN.md)
2. Detailed step-by-step skill usage instructions
3. oh-my-openagent compatibility explanation
4. Agent/skill invocation guide with when-to-use decision matrix

---

## TDD Approach (Documentation Testing)

### Verification Criteria (Acceptance Tests)

| Requirement | Verification Method | Success Criteria |
|-------------|---------------------|------------------|
| Chinese README exists | File existence check | `README_CN.md` present, mirrors English structure |
| Detailed skill usage | Content verification | Each skill category has step-by-step examples |
| oh-my-openagent section | Content verification | Clear compatibility statement (yes/no/partial) |
| Agent/skill guide | Content verification | Decision matrix table with all agents/skills |

### Pre-Commit Validation

Before each commit:
1. Markdown lint (if tool available) or manual review
2. Link verification (no broken relative links)
3. Table formatting check (proper alignment)
4. Chinese character encoding (UTF-8 verified)

---

## Work Breakdown (Atomic Units)

### Unit 1: Research oh-my-openagent Compatibility

**Goal**: Determine compatibility between OpenCode Game Studios and oh-my-openagent

**Status**: IN_PROGRESS (librarian agent running)

**Tasks**:
- [ ] Collect librarian research results
- [ ] Determine: Are they complementary? Mutually exclusive? Same framework?
- [ ] Draft compatibility section content

**Output**: Compatibility statement for README

---

### Unit 2: Enhance English README (README.md)

**Goal**: Expand README with detailed skill instructions and agent guide

**Depends on**: Unit 1 (for oh-my-openagent section)

**Tasks**:

#### 2.1 Add Detailed Skills Section

Create subsection for each skill category with:
- **Purpose** (when to use)
- **Invocation syntax** (exact command)
- **Workflow steps** (step-by-step from SKILL.md)
- **Example scenario** (concrete use case)
- **Output produced** (what user gets)

Skill categories to document:
1. **Onboarding Workflow** (start)
2. **Ideation Workflow** (brainstorm)
3. **Engine Setup** (setup-engine)
4. **Planning Workflow** (sprint-plan)
5. **Review Workflows** (code-review, design-review)
6. **Godot Technical Skills** (godot-specialist, godot-gdscript, godot-shader, godot-gdextension)
7. **Leadership Skills** (creative-director, technical-director, producer, game-designer, lead-programmer)

#### 2.2 Add Agent System Guide

New section: "OpenCode Agent System"

Content:
- **Subagent Types**: explore, librarian, oracle, metis, momus, plan
- **Categories**: visual-engineering, ultrabrain, deep, artistry, quick, writing, unspecified-low/high
- **Cost tiers**: FREE (explore), CHEAP (librarian), EXPENSIVE (oracle, metis, momus)
- **When to use each**: Decision matrix table

#### 2.3 Add Agent-Skill Interaction Guide

New section: "Working with Agents and Skills"

Content:
- How skills differ from agents
- When to use skills vs agents
- Skill → Agent delegation patterns
- Common workflow combinations

#### 2.4 Add oh-my-openagent Compatibility Section

New section: "Compatibility with oh-my-openagent"

Content (based on Unit 1 research):
- What oh-my-openagent is
- Architecture comparison
- Compatibility status (can they be used together?)
- Integration recommendations if applicable

---

### Unit 3: Create Chinese README (README_CN.md)

**Goal**: Full Chinese translation mirroring enhanced English README

**Depends on**: Unit 2 (must translate final English version)

**Tasks**:
- [ ] Translate all enhanced content
- [ ] Maintain identical structure
- [ ] Preserve all tables, code blocks, links
- [ ] Verify Chinese terminology accuracy

**Note**: Create after English README is finalized to avoid sync issues.

---

## Atomic Commit Strategy

### Commit 1: Research Results Integration
```
docs: Add oh-my-openagent compatibility research

- Document compatibility findings
- Explain architecture relationship
- Provide integration guidance

Scope: New section in README (oh-my-openagent compatibility)
Files: README.md (partial update)
```

### Commit 2: Enhanced Skills Documentation
```
docs: Add detailed skill usage instructions

- Expand each skill category with step-by-step guide
- Add invocation syntax examples
- Include workflow steps from SKILL.md files
- Add concrete use case examples

Scope: Skills section expansion
Files: README.md
```

### Commit 3: Agent System Guide
```
docs: Add OpenCode agent system documentation

- Document subagent types (explore, librarian, oracle, etc.)
- Explain categories and cost tiers
- Add decision matrix for when to use each agent
- Document agent-skill interaction patterns

Scope: New section (Agent System + Agent-Skill Guide)
Files: README.md
```

### Commit 4: Chinese Translation
```
docs: Add Chinese README (README_CN.md)

- Complete translation of enhanced README
- Maintain identical structure
- Preserve tables, code blocks, links

Scope: New file
Files: README_CN.md
```

---

## File Change Summary

| File | Action | Lines Changed (Est.) |
|------|--------|---------------------|
| README.md | Modify | +200-300 lines (expand existing sections, add new) |
| README_CN.md | Create | ~400 lines (full translation) |

---

## Quality Checklist (Per Commit)

- [ ] All links relative to project root work
- [ ] Tables properly formatted
- [ ] Code blocks have correct syntax markers
- [ ] No markdown lint errors
- [ ] UTF-8 encoding verified (especially for Chinese)
- [ ] Consistent heading hierarchy
- [ ] All skill names match actual skill filenames

---

## Risk Assessment

| Risk | Mitigation |
|------|------------|
| oh-my-openagent unclear | Use web search to clarify before writing section |
| Chinese translation drift | Create CN after EN is finalized |
| Skill descriptions outdated | Cross-reference with actual SKILL.md files |
| Agent documentation incomplete | Use system prompt knowledge as source |

---

## Execution Order

```
[Unit 1: Research] → [Unit 2.4: oh-my-openagent section] → 
[Unit 2.1-2.3: Skills + Agents] → [Unit 3: Chinese translation] →
[Commit 1] → [Commit 2] → [Commit 3] → [Commit 4]
```

---

## Parallel Execution Opportunities

| Parallel Group | Units |
|----------------|-------|
| Group A (sequential) | Unit 1 → Unit 2.4 (depends on research) |
| Group B (parallel with A?) | Unit 2.1, 2.2, 2.3 can draft while waiting for research |
| Group C (after A+B) | Unit 3 (translation) |

**Recommended**: 
- Start drafting Unit 2.1-2.3 now (skills + agents don't depend on oh-my-openagent research)
- Collect Unit 1 results when notification arrives
- Complete Unit 2.4 with research findings
- Then Unit 3 (translation)

---

## Current Status

| Unit | Status | Blocker |
|------|--------|---------|
| Unit 1 | IN_PROGRESS | Waiting for librarian (bg_70ab9cf2) |
| Unit 2.1-2.3 | READY | Can start drafting |
| Unit 2.4 | BLOCKED | Needs Unit 1 results |
| Unit 3 | BLOCKED | Needs Unit 2 complete |

---

## Next Actions

1. **Now**: Draft Unit 2.1-2.3 content (skills documentation, agent guide)
2. **On notification**: Collect Unit 1 results, complete Unit 2.4
3. **After Unit 2**: Create Chinese translation (Unit 3)
4. **Final**: Execute atomic commits in order