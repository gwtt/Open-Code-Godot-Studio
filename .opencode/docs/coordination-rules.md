# Coordination Rules

本文件定义skill之间的协调和委托规则。

---

## 目标用户

**Team Lead (小队队长)**
- 2-3人小队的技术负责人 + 项目管理者
- 需要同时管理技术、美术协调和进度
- 实用优先，不追求企业级流程

---

## 协作层级

```
用户 (最终决策者)
    │
    ├── 领导核心 (队长日常)
    │       ├── start (入口路由)
    │       ├── producer (进度/范围)
    │       └── technical-director (技术决策)
    │
    ├── 执行支持 (日常工作)
    │       ├── godot-specialist (技术指导)
    │       ├── sprint-plan (进度规划)
    │       ├── art-coordinator (美术协调)
    │       └── prototype-mode (快速验证)
    │
    ├── 设计支持 (创意工作)
    │       ├── brainstorm (概念探索)
    │       ├── game-designer (系统设计)
    │       └── design-review (设计验证)
    │
    └── 深度技术 (特定领域)
            ├── godot-gdscript (GDScript模式)
            ├── godot-csharp (C#模式)
            ├── godot-shader (渲染特效)
            ├── godot-gdextension (原生扩展)
            └── code-review (代码质量)
```

---

## 语言选择决策

### 项目初始化时选择

在 `/setup-engine` 时确定：
- **GDScript 为主** — 快速迭代、游戏逻辑
- **C# 为主** — .NET 生态、数据处理
- **双语言** — 灵活组合

### 任务实现时选择

在 `/sprint-plan` 任务分解时：
- 每个任务可指定语言
- 双语言项目可临时选择

### 语言选择指南

| 场景 | 推荐 |
|------|------|
| 游戏逻辑 | GDScript |
| UI组件 | GDScript 或 C# |
| 数据处理 | C# |
| .NET库集成 | C# |
| 快速原型 | GDScript |
| 性能关键 | C# 或 GDExtension |

---

## 决策权限

| 决策类型 | 决策者 | 咨询 |
|----------|--------|------|
| 创意方向 | 用户 | creative-director |
| 技术架构 | 用户 (Team Lead) | technical-director |
| 范围/进度 | 用户 (Team Lead) | producer |
| 美术规格 | 用户 + 美术 | art-coordinator |
| 代码风格 | Team Lead | godot-gdscript |
| 原型范围 | Team Lead | prototype-mode |

---

## Skill 调用指南

### Team Lead 工作流 (队长视角)

| 场景 | 使用Skill | 输出 |
|------|-----------|------|
| 开始新项目 | `/start` | 路由 + 团队检测 |
| 探索游戏概念 | `/brainstorm` | game-concept.md |
| 配置引擎 | `/setup-engine` | 技术配置 |
| 规划Sprint | `/sprint-plan` | sprint文档 |
| 查看进度 | `/producer` | 状态报告 |
| 技术决策 | `/technical-director` | ADR文档 |
| 美术协调 | `/art-coordinator` | 资产请求/同步 |
| 快速验证 | `/prototype-mode` | 原型指南 |

### 技术工作流

| 场景 | 使用Skill | 输出 |
|------|-----------|------|
| 架构决策 | `/technical-director` | ADR文档 |
| 引擎问题 | `/godot-specialist` | 指导建议 |
| GDScript模式 | `/godot-gdscript` | 代码模式 |
| Shader开发 | `/godot-shader` | Shader指导 |
| 原生扩展 | `/godot-gdextension` | 扩展指导 |
| 代码审查 | `/code-review` | 审查报告 |

### 美术协调工作流 (NEW)

| 场景 | 使用Skill | 输出 |
|------|-----------|------|
| 创建资产请求 | `/art-coordinator` | 规格文档 |
| 检查命名规范 | `/art-coordinator` | 检查报告 |
| 导入设置 | `/art-coordinator` | 配置指南 |
| 同步进度 | `/art-coordinator` | 同步报告 |

---

## 冲突解决

### 设计冲突

1. **识别冲突** — 具体分歧是什么？
2. **映射到支柱** — 每个选项支持哪个支柱？
3. **咨询** → creative-director 评估
4. **用户决定** — 最终决策权

### 技术冲突

1. **识别冲突** — 什么不兼容？
2. **评估选项** — 每个方法的权衡
3. **咨询** → technical-director 评估
4. **用户决定** — 最终决策权

### 范围冲突

1. **识别冲突** — 容量 vs 范围
2. **提供选项** — 削减、简化、延期
3. **咨询** → producer 评估
4. **用户决定** — 最终决策权

---

## 委托规则

### 何时委托

| 从 | 委托到 | 原因 |
|----|--------|------|
| producer | technical-director | 技术可行性评估 |
| producer | art-coordinator | 美术资源协调 |
| game-designer | technical-director | 设计可行性检查 |
| technical-director | godot-specialist | 引擎特定问题 |
| technical-director | prototype-mode | 快速验证方案 |
| art-coordinator | producer | 资产进度同步 |

### 委托格式

```markdown
**从**: [来源skill]
**到**: [目标skill]
**问题**: [具体问题]
**背景**: [相关上下文]
**需要**: [期望输出]
```

---

## 域边界

Skill不应修改其域外的文件，除非明确协调：

| 域 | 文件路径 | 主要负责Skill |
|----|----------|---------------|
| 游戏逻辑 | `src/gameplay/**` | game-designer + programmers |
| 核心系统 | `src/core/**` | technical-director |
| UI | `src/ui/**` | UI developers |
| 美术资产 | `assets/**` | art-coordinator + artist |
| 设计文档 | `design/gdd/**` | creative-director + game-designer |
| 生产文档 | `production/**` | producer + sprint-plan |
| 原型 | `prototypes/**` | prototype-mode |
| 测试 | `tests/**` | QA / programmers |

跨域修改需要:
1. 识别受影响的域
2. 通知域负责人
3. 协调实现
4. 集成测试

---

## 典型工作流

### 新项目启动

```
/start → 检测团队结构
    ↓
/brainstorm → game-concept.md
    ↓
/setup-engine → 技术配置
    ↓
/sprint-plan → Sprint 1 (含美术估算)
    ↓
[开发工作...]
```

### Team Lead 周循环

```
周一: /sprint-plan review → 进度检查
周三: /art-coordinator → 美术同步  
周五: /producer → 周总结
```

### 新功能开发

```
/design-review → 验证设计
    ↓
/art-coordinator → 请求美术资产
    ↓
/prototype-mode → 快速验证 (可选)
    ↓
[选择语言: GDScript 或 C#]
    ↓
/technical-director → 架构检查
    ↓
/godot-gdscript 或 /godot-csharp → 实现指导
    ↓
/code-review → 质量检查
```

### 语言选择流程 (双语言项目)

```
任务分解时:
    │
    ├── 游戏逻辑? → GDScript
    │
    ├── UI组件? → GDScript 或 C#
    │
    ├── 数据处理? → C#
    │
    ├── .NET库? → C#
    │
    ├── 快速原型? → GDScript
    │
    └── 性能关键? → C# 或 GDExtension
```

### 美术协调流程

```
/art-coordinator → 创建资产请求
    ↓
[美术制作...]
    ↓
/art-coordinator → 检查命名 + 导入设置
    ↓
[程序使用...]
```

---

## 文档模板位置

| 模板 | 路径 | 用途 |
|------|------|------|
| 架构决策记录 | `.opencode/docs/templates/adr-template.md` | ADR |
| Sprint计划 | `.opencode/docs/templates/sprint-template.md` | Sprint |
| 功能规格 | `.opencode/docs/templates/feature-spec-template.md` | 功能规格 |
| 里程碑报告 | `.opencode/docs/templates/milestone-report-template.md` | 进度报告 |
| 美术请求 | `.opencode/docs/templates/art-request-template.md` | 资产规格 |
| 技术规格 | `.opencode/docs/templates/technical-spec-template.md` | 实现计划 |

---

## Skill 总览 (18个)

| 分类 | Skills | PM相关性 |
|------|--------|----------|
| **领导核心** | start, producer, technical-director | 🔴 HIGH |
| **执行支持** | godot-specialist, sprint-plan, art-coordinator, prototype-mode | 🔴 HIGH |
| **设计支持** | brainstorm, game-designer, design-review | 🟡 MEDIUM |
| **深度技术** | godot-gdscript, godot-csharp, godot-shader, godot-gdextension, code-review | 🟡 MEDIUM |
| **顾问角色** | creative-director, lead-programmer | 🟢 ADVISORY |