---
name: godot-shader
description: Godot shader specialist for Godot shading language, visual shaders, particles, post-processing, and rendering optimization.
license: MIT
---

# Godot Shader Specialist Skill

This skill provides expert guidance for shaders, VFX, and rendering in Godot 4.

## Purpose

Use this skill when:
- Writing Godot shading language code
- Creating visual shader graphs
- Implementing particle systems
- Setting up post-processing effects
- Optimizing rendering performance
- Working with Godot's rendering pipeline

## Shader Types in Godot 4

| Type | Use Case |
|------|----------|
| `spatial` | 3D objects, materials, surfaces |
| `canvas_item` | 2D sprites, UI, Canvas layers |
| `particles` | GPU particle processing |
| `sky` | Sky rendering, atmosphere |
| `fog` | Volumetric fog effects |

## Spatial Shader Structure

```glsl
shader_type spatial;

// Vertex processor
void vertex() {
    // Modify VERTEX, NORMAL, UV, etc.
}

// Fragment processor
void fragment() {
    // Modify ALBEDO, METALLIC, ROUGHNESS, NORMAL_MAP, etc.
}

// Light processor (optional)
void light() {
    // Modify DIFFUSE_LIGHT, SPECULAR_LIGHT
}
```

## Canvas Item Shader Structure

```glsl
shader_type canvas_item;

void vertex() {
    // Modify VERTEX, COLOR, UV
}

void fragment() {
    // Modify COLOR, modify texture output
}

void light() {
    // 2D lighting (optional)
}
```

## Key Built-in Variables

### Spatial Shaders

| Variable | Type | Purpose |
|----------|------|---------|
| `VERTEX` | vec3 | World-space vertex position |
| `NORMAL` | vec3 | Vertex normal |
| `UV` / `UV2` | vec2 | Texture coordinates |
| `ALBEDO` | vec3 | Base color |
| `METALLIC` | float | Metalness factor |
| `ROUGHNESS` | float | Surface roughness |
| `NORMAL_MAP` | vec3 | Tangent-space normal |
| `EMISSION` | vec3 | Self-illumination |
| `AO` | float | Ambient occlusion |
| `SSS_STRENGTH` | float | Subsurface scattering |

### Canvas Item Shaders

| Variable | Type | Purpose |
|----------|------|---------|
| `VERTEX` | vec2 | Screen-space position |
| `COLOR` | vec4 | Vertex color |
| `UV` | vec2 | Texture coordinates |
| `TEXTURE` | sampler2D | Source texture |
| `TIME` | float | Elapsed time |

## Uniforms and Parameters

```glsl
// Basic uniforms
uniform vec4 color : source_color = vec4(1.0);
uniform float intensity : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D texture_map : hint_albedo;

// Texture hints
hint_albedo        // Color/opacity texture
hint_normal        // Normal map
hint_roughness     // Roughness map
hint_metallic      // Metallic map
hint_default_black // Black default
hint_default_white // White default
```

## Common Shader Patterns

### Dissolve/Reveal Effect

```glsl
shader_type spatial;

uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D dissolve_texture;

void fragment() {
    float dissolve = texture(dissolve_texture, UV).r;
    if (dissolve < dissolve_amount) {
        ALPHA = 0.0;
    }
}
```

### Outline Effect (Canvas)

```glsl
shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float outline_width = 2.0;

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * outline_width;
    vec4 sprite_color = texture(TEXTURE, UV);
    float alpha = -4.0 * sprite_color.a;
    
    alpha += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV - vec2(size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    alpha += texture(TEXTURE, UV - vec2(0.0, size.y)).a;
    
    COLOR = mix(sprite_color, outline_color, alpha);
}
```

### Water/Wave Effect

```glsl
shader_type spatial;

uniform float wave_speed = 1.0;
uniform float wave_amplitude = 0.1;
uniform vec2 wave_direction = vec2(1.0, 0.0);

void vertex() {
    float wave = sin(TIME * wave_speed + VERTEX.x * wave_direction.x + VERTEX.z * wave_direction.y);
    VERTEX.y += wave * wave_amplitude;
}
```

## Particle Shaders

```glsl
shader_type particles;

// Process particles on GPU
void start() {
    // Initial particle setup
    COLOR = vec4(1.0);
    TRANSFORM[3].xyz = EMISSION_TRANSFORM[3].xyz;
}

void process() {
    // Update each frame
    COLOR.a -= 0.1 * DELTA;
    TRANSFORM[3].xyz += VELOCITY * DELTA;
}
```

## Visual Shader Graphs

For non-programmers or prototyping:

1. Create `ShaderMaterial` in inspector
2. Click "Use Visual Shader"
3. Connect nodes in the graph editor
4. Available node categories:
   - Input (Time, UV, Vertex attributes)
   - Output (Albedo, Alpha, etc.)
   - Texture (Sampler2D operations)
   - Math (Add, Multiply, Sin, Cos)
   - Vector operations

## Performance Optimization

### Best Practices

- **Minimize texture reads** — Cache results when possible
- **Use lower precision** — `mediump` for mobile
- **Avoid complex lighting** — Use simpler models for non-essential objects
- **Batch similar shaders** — Share materials across objects
- **Precompute values** — Move calculations to vertex shader
- **Profile** — Use Godot's built-in profiler

### Mobile Considerations

```glsl
render_mode blend_add, unshaded, cull_disabled;

// Use lower precision for mobile
uniform lowp vec4 color : source_color;
```

## Post-Processing

Godot 4 post-processing via `Compositor`:

- Bloom
- Screen-space reflections (SSR)
- Screen-space ambient occlusion (SSAO)
- Volumetric fog
- Glow
- Color correction
- Custom post-processing via `CompositorEffect`

## Common Pitfalls

- ❌ Forgetting `shader_type` declaration
- ❌ Not using texture hints for editor preview
- ❌ Complex fragment shaders on mobile
- ❌ Ignoring `TIME` updates (effects won't animate)
- ❌ Not setting proper render modes
- ❌ Using deprecated Godot 3 syntax

## Integration with GDScript

```gdscript
# Set shader parameter from code
material.set_shader_parameter("dissolve_amount", 0.5)
material.set_shader_parameter("outline_color", Color.RED)

# Access shader material
var shader_mat = $Sprite.material as ShaderMaterial
shader_mat.set_shader_parameter("intensity", 0.8)
```

## Version Awareness

1. Read `.opencode/docs/engine-reference/godot/VERSION.md`
2. Godot 4 changed shader syntax from Godot 3 — verify all examples
3. New features: Compositor, improved VFX graph, native particles