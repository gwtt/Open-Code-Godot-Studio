---
name: resume
description: 快速恢复项目上下文 — 新会话中读取已有配置，无需重新走 /start 流程。
license: MIT
phase_automation:
  auto_proceed_default: true
  phases:
    - phase: "Phase 1: Read Context"
      auto_conditions:
        - condition_type: "file_exists"
          target: ".opencode/project-context.md"
          action_if_met: "proceed"
          notification: "✅ 项目上下文文件已找到，自动恢复"
          fallback_action: "suggest_start"
    - phase: "Phase 2: Summarize"
      auto_conditions:
        - condition_type: "previous_phase_success"
          action_if_met: "proceed"
          notification: "✅ 上下文已恢复，展示项目状态摘要"
---

# 快速恢复 Skill (Resume)

在新会话中快速恢复项目上下文，避免重新走 `/start` 的完整交互流程。

---

## ⚠️ 与 /start 的区别

| 指令 | 用途 | 交互性 |
|------|------|--------|
| `/start` | 首次项目初始化 | 5阶段交互式 |
| `/resume` | 新会话恢复上下文 | 自动读取，1步完成 |

**使用场景**:
- 新会话开始，项目已初始化 → 用 `/resume`
- 项目尚未初始化 → 用 `/start`
- 会话中途想重新确认状态 → 用 `/resume`

---

## Phase 1: Read Context (自动)

**ACTION**: 读取以下文件（静默执行）:
- `.opencode/project-context.md` → 项目基本信息
- `.opencode/docs/technical-preferences.md` → 技术偏好
- `.opencode/mcp.json` → MCP 配置状态
- `design/gdd/game-concept.md` → 游戏概念（如存在）
- `production/sprints/current.md` → 当前 Sprint（如存在）
- Check `src/` directory → 源码状态

**IF `project-context.md` NOT FOUND**:
```
⚠️ 未找到项目上下文文件。
这说明项目尚未通过 /start 初始化。

建议：运行 /start 完成首次项目设置。
```
**STOP**: 不继续后续阶段。

**IF `project-context.md` EXISTS**:
- 读取所有信息
- 自动进入 Phase 2

---

## Phase 2: Summarize (自动)

**ACTION**: 基于读取的信息，输出项目状态摘要:

```
📋 项目上下文已恢复
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
团队结构: [从 project-context.md]
项目阶段: [从 project-context.md]
MCP 配置: [从 mcp.json]
引擎版本: [从 technical-preferences.md]
游戏概念: [从 game-concept.md 或 "尚未定义"]
当前 Sprint: [从 current.md 或 "尚未开始"]
源码状态: [src/ 目录扫描结果]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

建议下一步:
[基于当前状态推荐合适的 skill]
```

**推荐逻辑**:
- 没有游戏概念 → `/brainstorm`
- 有概念但没引擎配置 → `/setup-engine`
- 有引擎但没 Sprint → `/sprint-plan`
- 正在开发中 → `/godot-specialist` 或 `/code-review`
- 有设计文档要验证 → `/design-review`

---

## Error Handling

| Error | Fallback |
|-------|----------|
| project-context.md 不存在 | 建议 `/start` |
| project-context.md 不完整 | 读取已有部分，提示缺失项 |
| mcp.json 读取失败 | 标注 MCP 状态未知 |
| 用户想重新初始化 | 指引 `/start` |

---

## Quick Reference

| 场景 | 使用 |
|------|------|
| 新会话，项目已存在 | `/resume` |
| 新会话，新项目 | `/start` |
| 会话中途查看状态 | `/resume` |
| 更新项目配置 | `/start` (会跳过已有部分) |