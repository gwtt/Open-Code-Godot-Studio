---
name: start
description: First-time onboarding — asks where you are, then guides you to the right workflow. No assumptions.
license: MIT
---

# Guided Onboarding Skill

This skill is the entry point for new users. It does NOT assume you have a game idea, an engine preference, or any prior experience. It asks first, then routes you to the right workflow.

## Workflow

### 1. Detect Project State (Silent)

Before asking anything, silently gather context:

Check:
- **Engine configured?** Read `.opencode/docs/technical-preferences.md`
- **Game concept exists?** Check for `design/gdd/game-concept.md`
- **Source code exists?** Check for source files in `src/` (`.gd`, `.cs`, `.cpp`)
- **Prototypes exist?** Check for subdirectories in `prototypes/`
- **Design docs exist?** Count markdown files in `design/gdd/`
- **Production artifacts?** Check `production/sprints/` or `production/milestones/`

### 2. Ask Where the User Is

Present these 4 options:

> **Welcome to OpenCode Game Studios!**
>
> Where are you at with your game idea right now?
>
> **A) No idea yet** — I don't have a game concept at all. I want to explore.
>
> **B) Vague idea** — I have a rough theme or genre in mind but nothing concrete.
>
> **C) Clear concept** — I know the core idea but haven't documented it.
>
> **D) Existing work** — I already have design docs, prototypes, or code.

Wait for the user's answer.

### 3. Route Based on Answer

#### If A: No idea yet

1. Acknowledge starting from zero is fine
2. Recommend `/brainstorm` for creative exploration
3. Show the recommended path:
   - `/brainstorm` → discover your game concept
   - `/setup-engine` → configure Godot
   - Design and prototype

#### If B: Vague idea

1. Ask them to share their idea
2. Recommend `/brainstorm [hint]` to develop it
3. Show the path:
   - `/brainstorm [hint]` → develop into concept
   - `/setup-engine` → configure engine
   - Design and prototype

#### If C: Clear concept

1. Ask follow-up questions:
   - What's the genre and core mechanic?
   - Engine preference or need help choosing?
   - Rough scope (jam, small, large)?
2. Offer paths:
   - `/brainstorm` to formalize concept
   - `/setup-engine` if confident
3. Show the path:
   - `/brainstorm` or `/setup-engine`
   - `/design-review` to validate
   - `/sprint-plan` to organize work

#### If D: Existing work

1. Share what you found in Step 1
2. Recommend next steps based on gaps
3. If engine not configured, suggest `/setup-engine`

### 4. Confirm Before Proceeding

After presenting options, ask which step they'd like to take first.

### 5. Hand Off

Once the user has a clear next action, the skill's job is done.

## Edge Cases

- **User picks D but project is empty**: Redirect to A or B
- **User picks A but project has code**: Ask if they meant D
- **User is returning**: Skip onboarding — "You're already set up! Want to continue?"

## Collaborative Protocol

1. **Ask first** — Never assume the user's state
2. **Present options** — Give clear paths
3. **User decides** — They pick the direction
4. **No auto-execution** — Recommend, don't run without asking