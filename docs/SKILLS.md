# Skills 完整指南

> 所有 18 个技能的详细说明和使用指南

---

## 快速索引

| 分类 | Skills |
|------|--------|
| **领导核心** | `start`, `producer`, `technical-director` |
| **执行支持** | `godot-specialist`, `sprint-plan`, `art-coordinator`, `prototype-mode` |
| **设计支持** | `brainstorm`, `game-designer`, `design-review` |
| **深度技术** | `godot-gdscript`, `godot-csharp`, `godot-shader`, `godot-gdextension`, `code-review` |
| **顾问角色** | `creative-director`, `lead-programmer` |
| **其他** | `setup-engine` |

---

## 领导核心

### `/start`

**用途**: 入口路由，检测团队状态，引导到正确的 workflow

**调用方式**:
```
/start
```

**功能**:
- 检测项目状态（是否有游戏概念、引擎配置等）
- 询问团队结构（单人/2人/3人）
- 根据状态推荐下一步操作

**适合场景**:
- 第一次使用项目
- 不确定从哪里开始
- 新项目启动

---

### `/producer`

**用途**: 进度管理、范围控制、风险评估

**调用方式**:
```
/producer
/producer 进度报告
/producer 风险评估
```

**功能**:
- 查看当前 Sprint 进度
- 生成状态报告
- 评估风险
- 处理范围变更

**适合场景**:
- 查看项目进度
- 需要状态报告
- 范围变更决策

---

### `/technical-director`

**用途**: 架构决策、技术标准、性能预算

**调用方式**:
```
/technical-director
/technical-director 架构决策
/technical-director 性能预算
```

**功能**:
- 创建 ADR (架构决策记录)
- 技术栈选择建议
- 代码标准制定
- 技术债评估

**适合场景**:
- 需要做技术决策
- 架构设计
- 性能优化规划

---

## 执行支持

### `/godot-specialist`

**用途**: Godot 引擎模式和最佳实践

**调用方式**:
```
/godot-specialist [问题]
```

**功能**:
- 语言选择指导 (GDScript / C# / GDExtension)
- 场景/节点架构设计
- 性能优化建议
- 引擎特定问题解答

**关键决策矩阵**:

| 需求 | 推荐 |
|------|------|
| 游戏逻辑 | GDScript |
| 快速原型 | GDScript |
| 性能关键 | GDExtension |
| 跨平台库 | C# |

**适合场景**:
- 不确定用什么语言实现
- 需要引擎最佳实践
- 性能优化指导

---

### `/sprint-plan`

**用途**: Sprint 规划和任务估算

**调用方式**:
```
/sprint-plan              # 创建新 Sprint
/sprint-plan review       # 查看当前 Sprint
/sprint-plan complete     # 完成 Sprint
```

**功能**:
- 创建 Sprint 文档
- 任务分解和估算
- 容量规划（含美术）
- 风险评估

**估算参考**:

| Points | 复杂度 | 示例 |
|--------|--------|------|
| 1 | 简单 | 改文案、改配置 |
| 2 | 小 | 加 UI 元素 |
| 3 | 中等 | 新小功能 |
| 5 | 复杂 | 新系统 |
| 8 | 大 | 大功能 |

**适合场景**:
- 规划新 Sprint
- 检查进度
- 团队容量规划

---

### `/art-coordinator`

**用途**: 美术协调、资产管道、命名规范

**调用方式**:
```
/art-coordinator
/art-coordinator 创建资产请求
/art-coordinator 检查命名规范
```

**功能**:
- 创建资产请求规格
- 命名规范检查
- 导入设置指导
- 美术-程序同步

**资产命名规范**:

| 类型 | 格式 | 示例 |
|------|------|------|
| Sprite | `[type]_[name].png` | `char_player.png` |
| UI | `ui_[element].png` | `ui_button.png` |
| Audio | `sfx_[action].wav` | `sfx_jump.wav` |

**适合场景**:
- 需要请求美术资产
- 检查资产命名
- 配置导入设置

---

### `/prototype-mode`

**用途**: 快速原型验证，一次性代码模式

**调用方式**:
```
/prototype-mode [验证什么]
```

**功能**:
- 定义原型范围
- 提供快速实现代码
- 评估原型结果
- 原型到生产转换指导

**原型原则**:
- 速度 > 质量
- 只验证一个核心假设
- 1-4 小时完成
- 准备好扔掉重来

**适合场景**:
- 快速验证想法
- 测试核心玩法
- 技术可行性验证

---

## 设计支持

### `/brainstorm`

**用途**: 游戏概念探索

**调用方式**:
```
/brainstorm                    # 开放探索
/brainstorm "你的想法"          # 发展特定想法
/brainstorm open               # 最大开放性
```

**功能**:
- 玩家体验探索
- 核心玩法定义
- 设计支柱确立
- 生成游戏概念文档

**输出**:
- `design/gdd/game-concept.md`
- 设计支柱 (3-5个)
- 核心循环定义
- 范围评估

---

### `/game-designer`

**用途**: 游戏系统和机制设计

**调用方式**:
```
/game-designer [系统名]
```

**功能**:
- 设计游戏机制
- 创建系统文档
- 经济系统设计
- 进度系统设计

**输出**:
- 系统设计文档
- 机制详细说明
- 平衡参数

---

### `/design-review`

**用途**: 设计文档审查

**调用方式**:
```
/design-review              # 审查所有设计
/design-review [文件]        # 审查特定文件
```

**功能**:
- 支柱对齐检查
- 玩家体验评估
- 机制清晰度检查
- 生成审查报告

**审查维度**:
- 支柱对齐
- 玩家体验
- 机制清晰
- 范围现实

---

## 深度技术

### `/godot-gdscript`

**用途**: GDScript 代码模式和最佳实践

**调用方式**:
```
/godot-gdscript [问题]
```

**功能**:
- 静态类型指导
- 信号架构设计
- 协程模式
- 性能优化

**代码规范**:
```gdscript
# ✅ 正确
var health: int = 100
func take_damage(amount: int) -> void:
    pass

# ❌ 错误
var health = 100
func take_damage(amount):
    pass
```

---

### `/godot-csharp`

**用途**: Godot C# 开发和 .NET 集成

**调用方式**:
```
/godot-csharp [问题]
```

**功能**:
- C# 命名规范
- Godot C# API 模式
- async/await 异步编程
- 信号与事件
- .NET 库集成

**代码规范**:
```csharp
// ✅ 正确
public float Health { get; set; } = 100f;
public void TakeDamage(float amount) { }

[Signal]
public delegate void HealthChangedEventHandler(float newHealth);

// ❌ 错误
var health = 100f;  // 隐式类型
Console.WriteLine("...");  // 应用 GD.Print()
```

**适合场景**:
- 需要 .NET 生态系统
- 复杂数据处理
- 多线程需求
- 外部 C# 库集成

---

### `/godot-shader`

**用途**: Godot Shader 开发

**调用方式**:
```
/godot-shader [需求]
```

**功能**:
- Shader 编写指导
- 视觉 Shader 图
- 后处理效果
- 渲染优化

**Shader 类型**:
- spatial (3D)
- canvas_item (2D)
- particles (粒子)

---

### `/godot-gdextension`

**用途**: C++/Rust 原生扩展

**调用方式**:
```
/godot-gdextension [需求]
```

**功能**:
- GDExtension 配置
- 原生模块开发
- 性能关键代码
- 外部库集成

**使用场景**:
- 性能关键 (>1000 calls/frame)
- 复杂数学运算
- 外部库集成

---

### `/code-review`

**用途**: 代码质量审查

**调用方式**:
```
/code-review              # 审查最近更改
/code-review [路径]        # 审查特定路径
```

**功能**:
- 代码正确性检查
- 质量评估
- 性能检查
- Godot 特定检查

**审查报告**:
- 🔴 阻塞问题
- 🟡 重要问题
- 🟢 建议

---

## 顾问角色

### `/creative-director`

**用途**: 创意愿景指导

**功能**:
- 设计支柱定义
- 创意冲突解决
- 愿景对齐检查

---

### `/lead-programmer`

**用途**: 代码架构协调

**功能**:
- 代码架构设计
- 编码标准制定
- 技术实现协调

---

## 其他

### `/setup-engine`

**用途**: 配置 Godot 引擎

**调用方式**:
```
/setup-engine              # 引导配置
/setup-engine godot 4.6.1    # 指定版本
```

**功能**:
- 更新 OPENCODE.md
- 创建技术偏好文档
- 创建引擎引用文档
- 创建项目目录结构

---

## 相关文档

- [工作流指南](WORKFLOW.md) — 典型工作流程
- [快速入门](QUICK-START.md) — 5 分钟入门
- [教程](tutorials/) — 实战教程