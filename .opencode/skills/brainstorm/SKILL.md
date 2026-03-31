---
name: brainstorm
description: Explore game ideas from scratch using professional frameworks — MDA, player psychology, verb-first design. Develops vague concepts into formalized game concepts.
license: MIT
---

# Brainstorm Skill

Guided ideation using professional game design frameworks to explore and develop game concepts.

## Workflow

### 1. Initial Input

Accepts optional seed input:
- `/brainstorm` — Open exploration
- `/brainstorm "space exploration game"` — Develop specific idea
- `/brainstorm open` — Maximum openness to new ideas

### 2. Discovery Phase

#### If No Seed Provided

Explore interests and preferences:

1. **Player Experience Questions**
   - What feelings do you want players to have?
   - What games do you love? What makes them special?
   - What do you want to avoid?

2. **Verb Exploration**
   - What actions should players take?
   - What verbs define the experience? (explore, build, fight, discover...)
   - What's the core loop?

3. **Theme and Setting**
   - What worlds interest you?
   - What tone? (serious, playful, dark, hopeful...)
   - Any specific aesthetic preferences?

#### If Seed Provided

Develop the seed:
1. Clarify what excites you about this idea
2. Identify the core fantasy
3. Explore what makes it unique

### 3. Concept Development

Use frameworks to structure the idea:

#### MDA Analysis

| Layer | Question | Your Concept |
|-------|----------|--------------|
| **Aesthetics** | What feelings? | |
| **Dynamics** | What emergent behavior? | |
| **Mechanics** | What rules? | |

#### Design Pillars (3-5)

Define the foundational principles:
1. [Pillar 1] — e.g., "Tactical depth over twitch skill"
2. [Pillar 2] — e.g., "Meaningful player choice"
3. [Pillar 3] — e.g., "Emergent storytelling"

#### Player Psychology

Map to Self-Determination Theory:
- **Autonomy** — How do players have agency?
- **Competence** — How do players grow mastery?
- **Relatedness** — How do players connect?

#### Target Player

Define who this is for:
- Experience level (casual, core, hardcore)
- Time commitment (session length, total hours)
- Platform preference
- What they value in games

### 4. Scope Considerations

Help user understand realistic scope:

| Scope | Team | Duration | Features |
|-------|------|----------|----------|
| **Jam** | Solo | 48h-1w | 1-2 core mechanics |
| **Small** | Solo/2-3 | 1-6mo | 3-5 systems |
| **Medium** | 3-10 | 6-18mo | Multiple systems |
| **Large** | 10+ | 18mo+ | Full production |

### 5. Engine Recommendation

Based on concept, recommend engine:

| Godot 4 | Unity | Unreal 5 |
|---------|-------|----------|
| 2D games | Mobile | AAA 3D |
| Small-mid 3D | Cross-platform | Photorealism |
| Solo/small teams | Mid-scope | Large teams |
| Open source | C# ecosystem | C++/Blueprint |

### 6. Output: Game Concept Document

Create `design/gdd/game-concept.md`:

```markdown
# [Game Title]

## Elevator Pitch
[1-2 sentence description]

## Design Pillars
1. [Pillar 1]
2. [Pillar 2]
3. [Pillar 3]

## Core Loop
1. [Action]
2. [Reward]
3. [Progression]

## Target Player
[Player persona description]

## Key Features
- [Feature 1]
- [Feature 2]
- [Feature 3]

## Scope
[Size and timeline estimate]

## Recommended Engine
[Engine] — [Reasoning]

## Next Steps
1. /setup-engine [engine]
2. Design core systems
3. Prototype core mechanic
```

### 7. Confirm and Save

Before writing:
1. Present the concept document
2. Ask for adjustments
3. Get approval to write
4. Save to `design/gdd/game-concept.md`

## Collaborative Protocol

1. **Explore freely** — No wrong answers in brainstorming
2. **Structure progressively** — Add frameworks as clarity emerges
3. **User approves output** — Show document before saving
4. **Document decisions** — Record the "why" behind choices