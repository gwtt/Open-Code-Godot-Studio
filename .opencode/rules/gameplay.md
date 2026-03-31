# Gameplay Code Rules

Applies to: `src/gameplay/**`

## Enforced Standards

### Data-Driven Design

- All tunable values MUST be `@export` variables or Resources
- NO hardcoded magic numbers in gameplay logic
- Values should be adjustable without code changes

```gdscript
# ✅ Good
@export var move_speed: float = 300.0
@export var jump_height: float = 64.0

# ❌ Bad
velocity.x = 300.0  # Magic number!
```

### Delta Time Usage

- All time-dependent logic MUST use `delta`
- NO assumptions about frame rate
- Physics in `_physics_process(delta)`, visuals in `_process(delta)`

```gdscript
# ✅ Good
func _physics_process(delta: float) -> void:
    velocity += gravity * delta
    position += velocity * delta

# ❌ Bad
func _physics_process(_delta: float) -> void:
    velocity += gravity  # Ignores frame timing!
```

### Component Separation

- Gameplay logic MUST NOT reference UI directly
- Use signals to communicate state changes
- UI observes gameplay, never the reverse

```gdscript
# ✅ Good
signal health_changed(new_health: int, max_health: int)

func take_damage(amount: int) -> void:
    health -= amount
    health_changed.emit(health, max_health)

# ❌ Bad
func take_damage(amount: int) -> void:
    health -= amount
    $UI/HealthBar.value = health  # Direct UI reference!
```

### State Machines

- Use state machines for stateful behavior
- States should be clearly defined
- Transitions should be explicit

```gdscript
# ✅ Good
enum State { IDLE, RUNNING, JUMPING }
var _state: State = State.IDLE

func _physics_process(delta: float) -> void:
    match _state:
        State.IDLE: _process_idle(delta)
        State.RUNNING: _process_running(delta)
        State.JUMPING: _process_jumping(delta)

# ❌ Bad
var is_idle: bool = true
var is_running: bool = false
var is_jumping: bool = false  # Multiple bools = state machine needed
```

### Signals for Communication

- Use signals for child → parent communication
- Use signals for cross-system communication
- Type all signal parameters

```gdscript
# ✅ Good
signal health_changed(new_health: int, max_health: int)
signal died(killer: Node)

# ❌ Bad
signal health_changed  # No types
signal update  # Vague name
```

## Rationale

These rules ensure:
1. **Tunability** — Designers can adjust without code changes
2. **Consistency** — Frame-rate independent gameplay
3. **Testability** — UI can be mocked or replaced
4. **Maintainability** — Clear patterns reduce cognitive load