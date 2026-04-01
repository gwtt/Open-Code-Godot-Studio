# 资产请求模板

> 使用 `/art-coordinator` skill 自动生成

---

## 基本信息

| 字段 | 值 |
|------|-----|
| **资产名称** | [Asset Name] |
| **类型** | Sprite / UI / Background / Animation / Audio |
| **优先级** | P0 (阻塞) / P1 (重要) / P2 (期望) |
| **请求人** | [Your Name] |
| **负责人** | [Artist Name] |
| **截止日期** | [Date] |

---

## 规格说明

### Sprite / 角色图

| 参数 | 值 |
|------|-----|
| **尺寸** | [W x H] pixels |
| **格式** | PNG (透明背景) |
| **命名** | `[type]_[name]_[variant].png` |
| **数量** | [多少变体/方向] |
| **风格** | 像素风 / 手绘 / 卡通 / 写实 |

**动画帧 (如适用):**
- 帧数: [N]
- 帧率: [FPS]
- 动画列表: idle, walk, run, attack, hurt, death

### UI 元素

| 参数 | 值 |
|------|-----|
| **尺寸** | [W x H] pixels |
| **格式** | PNG |
| **命名** | `ui_[element]_[state].png` |

**状态变体:**
- [ ] Normal
- [ ] Hover
- [ ] Pressed
- [ ] Disabled
- [ ] Focused

**九宫格切片:**
```
┌───┬─────────┬───┐
│ L │   Top   │ R │
├───┼─────────┼───┤
│   │ Center  │   │
├───┼─────────┼───┤
│   │ Bottom  │   │
└───┴─────────┴───┘
Left: [X]  Right: [X]  Top: [Y]  Bottom: [Y]
```

### Background / 场景

| 参数 | 值 |
|------|-----|
| **尺寸** | [W x H] pixels |
| **格式** | PNG |
| **视差层** | [层数] |
| **命名** | `bg_[location]_[layer].png` |

### Audio / 音频

| 参数 | 值 |
|------|-----|
| **类型** | 音效 / 音乐 |
| **时长** | [秒数] |
| **格式** | WAV (音效) / OGG (音乐) |
| **命名** | `sfx_[action].wav` 或 `music_[location].ogg` |

**技术规格:**
- 采样率: 44100 Hz
- 声道: Mono (音效) / Stereo (音乐)
- 循环: 是/否 (音乐)

---

## 参考素材

### 风格参考
- [链接1]
- [链接2]

### 颜色方案
| 用途 | 颜色 |
|------|------|
| 主色 | #XXXXXX |
| 辅色 | #XXXXXX |
| 强调色 | #XXXXXX |

### 情绪板
[描述期望的视觉感受]

---

## 技术要求

### Godot 导入设置

#### Sprite
```
Filter: Nearest (像素风) / Linear (平滑)
Repeat: Disabled
Mipmaps: Disabled
Compression: VRAM Compressed
```

#### Audio
```
采样率: 44100 Hz
压缩: IMA ADPCM (音效) / Vorbis (音乐)
```

### 特殊要求
- [ ] 像素对齐
- [ ] Pivot点: 中心 / 底部 / 自定义
- [ ] 碰撞形状: 简要描述
- [ ] 图集合并: 是/否

---

## 验收标准

- [ ] 符合命名规范
- [ ] 尺寸正确
- [ ] 格式正确
- [ ] 风格一致
- [ ] 导入测试通过
- [ ] 游戏内效果确认

---

## 交付清单

| 文件 | 状态 | 备注 |
|------|------|------|
| [file1] | ⏳ 待制作 | |
| [file2] | ⏳ 待制作 | |

---

## 沟通记录

| 日期 | 内容 |
|------|------|
| [Date] | 初始请求 |

---

*创建时间: [DateTime]*
*最后更新: [DateTime]*