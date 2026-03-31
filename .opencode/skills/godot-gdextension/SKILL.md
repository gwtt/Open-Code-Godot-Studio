---
name: godot-gdextension
description: GDExtension specialist for C++/Rust native bindings, custom nodes, high-performance modules, and native code integration with Godot 4.
license: MIT
---

# GDExtension Specialist Skill

This skill provides expert guidance for creating native extensions in Godot 4 using C++, Rust, or other languages via GDExtension.

## Purpose

Use this skill when:
- Implementing performance-critical code (>1000 calls/frame)
- Creating custom native nodes or resources
- Integrating existing C++/Rust libraries
- Building specialized systems (pathfinding, physics queries, procedural generation)
- Setting up GDExtension build systems

## GDExtension Overview

GDExtension allows:
- Native performance without modifying engine source
- Custom nodes, resources, and editor plugins
- C++, Rust, Swift, and other language bindings
- Hot-reloading during development (C++ only on some platforms)

## When to Use GDExtension

| Use GDScript | Use GDExtension |
|--------------|-----------------|
| Game logic, state | Heavy math (physics, pathfinding) |
| UI, scene management | Procedural generation |
| Standard gameplay | >1000 calls/frame operations |
| Prototyping | Native library integration |
| Most game code | Custom rendering pipelines |

## Project Structure

```
project/
├── src/                    # GDScript source
├── native/                 # GDExtension source
│   ├── include/            # Header files
│   ├── src/                # Implementation
│   ├── SConstruct          # SCons build script
│   └── .gdextension        # Extension config
└── addons/
    └── my_extension/       # Compiled extension
        ├── bin/
        │   ├── my_extension.dll   # Windows
        │   ├── my_extension.so    # Linux
        │   └── my_extension.dylib # macOS
        └── my_extension.gdextension
```

## .gdextension Configuration

```ini
[configuration]

entry_symbol = "my_extension_library_init"
compatibility_minimum = "4.2"

[libraries]

windows.debug.x86_64 = "res://addons/my_extension/bin/my_extension.dll"
windows.release.x86_64 = "res://addons/my_extension/bin/my_extension.dll"
linux.debug.x86_64 = "res://addons/my_extension/bin/my_extension.so"
linux.release.x86_64 = "res://addons/my_extension/bin/my_extension.so"
macos.debug = "res://addons/my_extension/bin/my_extension.dylib"
macos.release = "res://addons/my_extension/bin/my_extension.dylib"
```

## C++ GDExtension Example

### Header (include/my_node.hpp)

```cpp
#ifndef MY_NODE_HPP
#define MY_NODE_HPP

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/core/class_db.hpp>

namespace my_extension {

class MyNode : public godot::Node {
    GDCLASS(MyNode, godot::Node)

private:
    double custom_value;

protected:
    static void _bind_methods();

public:
    MyNode();
    ~MyNode();

    void _process(double delta) override;

    void set_custom_value(double value);
    double get_custom_value() const;
};

} // namespace my_extension

#endif // MY_NODE_HPP
```

### Implementation (src/my_node.cpp)

```cpp
#include "my_node.hpp"

namespace my_extension {

void MyNode::_bind_methods() {
    godot::ClassDB::bind_method(godot::D_METHOD("set_custom_value", "value"), &MyNode::set_custom_value);
    godot::ClassDB::bind_method(godot::D_METHOD("get_custom_value"), &MyNode::get_custom_value);

    ADD_PROPERTY(godot::PropertyInfo(godot::Variant::FLOAT, "custom_value"), "set_custom_value", "get_custom_value");
}

MyNode::MyNode() : custom_value(0.0) {}
MyNode::~MyNode() {}

void MyNode::_process(double delta) {
    // High-performance processing here
}

void MyNode::set_custom_value(double value) {
    custom_value = value;
}

double MyNode::get_custom_value() const {
    return custom_value;
}

} // namespace my_extension
```

### Registration (src/register_types.cpp)

```cpp
#include "register_types.hpp"
#include "my_node.hpp"

#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

namespace my_extension {

void initialize_my_extension_module(godot::ModuleInitializationLevel p_level) {
    if (p_level != godot::MODULE_INITIALIZATION_LEVEL_SCENE) {
        return;
    }

    godot::ClassDB::register_class<MyNode>();
}

void uninitialize_my_extension_module(godot::ModuleInitializationLevel p_level) {
    if (p_level != godot::MODULE_INITIALIZATION_LEVEL_SCENE) {
        return;
    }
}

} // namespace my_extension

extern "C" {
GDExtensionBool GDE_EXPORT my_extension_library_init(
    GDExtensionInterfaceGetProcAddress p_get_proc_address,
    GDExtensionClassLibraryPtr p_library,
    GDExtensionInitialization *r_initialization
) {
    godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);

    init_obj.register_initializer(initialize_my_extension_module);
    init_obj.register_uninitializer(uninitialize_my_extension_module);
    init_obj.set_minimum_library_initialization_level(godot::MODULE_INITIALIZATION_LEVEL_SCENE);

    return init_obj.init();
}
}
```

## Rust GDExtension (godot-rust)

### Cargo.toml

```toml
[package]
name = "my_godot_extension"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
godot = { git = "https://github.com/godot-rust/gdext" }
```

### Rust Implementation

```rust
use godot::prelude::*;

#[derive(GodotClass)]
#[class(base=Node)]
struct MyRustNode {
    #[export]
    custom_value: f64,
    
    base: Base<Node>,
}

#[godot_api]
impl MyRustNode {
    #[func]
    fn process(&mut self, delta: f64) {
        // High-performance processing
    }
}

struct MyExtension;

#[gdextension]
unsafe impl GDExtension for MyExtension {
    fn init() {
        register_class::<MyRustNode>();
    }
}
```

## Build Systems

### SCons (C++)

```python
# SConstruct
SConscript("godot-cpp/SConstruct")

env = SConscript("godot-cpp/SConstruct")

env.Append(CPPPATH=["#include"])
env.Append(LIBPATH=["godot-cpp/bin"])

sources = Glob("src/*.cpp")

library = env.SharedLibrary(
    "bin/my_extension",
    source=sources,
    SHLIBSUFFIX=".dll"  # Adjust for platform
)
```

### Cargo (Rust)

```bash
cargo build --release
# Output in target/release/my_godot_extension.dll
```

## Performance Best Practices

### C++

- **Avoid allocations in hot paths** — Pre-allocate buffers
- **Use POD types** — Prefer `double` over `Variant` when possible
- **Cache godot object access** — Don't query same node repeatedly
- **Batch operations** — Process arrays in one call
- **Use `Ref<T>` properly** — Understand reference counting

### Rust

- **Zero-copy where possible** — Avoid unnecessary cloning
- **Use `godot::prelude::*` efficiently** — Only import what needed
- **Handle ownership correctly** — Understand Rust's ownership model
- **Profile with native tools** — Use Rust profiling tools

## Debugging

### Debug Build Configuration

```ini
[libraries]
windows.debug.x86_64 = "res://addons/my_extension/bin/my_extension_debug.dll"
```

### Hot Reloading

- C++: Works on some platforms, requires special build flags
- Rust: Requires restart of Godot editor

## Integration with GDScript

```gdscript
# Use custom node from GDExtension
var my_node = MyNode.new()
my_node.custom_value = 100.0
add_child(my_node)

# Call methods
my_node.process(0.016)
```

## Common Pitfalls

- ❌ Not matching Godot version in .gdextension
- ❌ Missing `entry_symbol` configuration
- ❌ Wrong library path format (platform-specific)
- ❌ Not registering classes properly
- ❌ Ignoring reference counting (memory leaks)
- ❌ Excessive Variant usage (performance hit)
- ❌ Not handling thread safety for concurrent access

## Version Awareness

1. Read `.opencode/docs/engine-reference/godot/VERSION.md`
2. GDExtension API changed significantly in Godot 4
3. godot-cpp and godot-rust versions must match engine version
4. Check for breaking changes in extension registration