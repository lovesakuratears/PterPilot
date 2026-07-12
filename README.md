# PterPilot

> 面向 PT 玩家的开源移动端管理工具 —— 插件化架构，一套代码覆盖 Android / iOS / 鸿蒙。

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-00B4A0?logo=flutter)](https://flutter.dev)
[![HarmonyOS](https://img.shields.io/badge/鸿蒙-支持-red?logo=huawei)](docs/harmonyos-build-guide.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#贡献)

---

## ✨ 特性

- 🎬 **影视发现** — 豆瓣 / TMDB 热门榜单，详情页一键搜种
- 🔍 **聚合搜索** — 多站点并发搜索，聚合展示，一键推种
- ⬇️ **下载器管理** — 支持 qBittorrent / Transmission 远程控制
- 🌐 **站点管理** — 多站点聚合，CookieCloud 一键同步，失效检测
- 🧩 **插件系统** — 核心框架 + 内置插件 + 社区插件，自由扩展
- 🔒 **隐私优先** — 所有数据仅存本地，Cookie/密钥加密存储
- 🎨 **液态玻璃设计** — Material 3 + 玻璃拟态，深浅双主题

## 📱 截图

| 发现 | 搜索 | 下载器 | 站点 | 我的 |
|------|------|--------|------|------|
| _待补充_ | _待补充_ | _待补充_ | _待补充_ | _待补充_ |

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0

### 运行

```bash
git clone https://github.com/lovesakuratears/PterPilot.git
cd PterPilot/pterpilot
flutter pub get
flutter run
```

### 构建

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# 鸿蒙 (HarmonyOS / OpenHarmony)
flutter build hap --release
```

**鸿蒙构建指南** 👉 [docs/harmonyos-build-guide.md](docs/harmonyos-build-guide.md)

## 🧩 插件开发

PterPilot 的所有功能模块都以插件形式存在。开发者可以为 PterPilot 开发自定义插件。

**👉 [插件开发文档](docs/plugin-development.md)**

### 插件类型

| 类型 | 说明 |
|------|------|
| 功能型插件 | 扩展 App 功能，如站点签到、数据看板、RSS 订阅 |
| 站点型插件 | 适配特定 PT 站点架构，提供搜索和用户信息解析 |
| 下载器插件 | 适配特定下载器，提供种子推送和任务管理 |

### 核心能力暴露

- 网络请求（自动携带站点 Cookie/UA）
- 本地存储（插件间数据隔离）
- 路由导航（侧边栏/底部导航注册）
- 下载器控制（种子推送/任务管理）
- 站点数据（读取站点列表和配置）
- 通知系统（Toast / 本地通知）
- 定时任务（后台周期性执行）

## 🏗️ 架构

```
┌──────────────────────────────────────────┐
│            UI 层 (Flutter Widgets)        │
│  5 Tab + 插件侧边栏 + 社区插件页面         │
├──────────────────────────────────────────┤
│          业务逻辑层 (Riverpod)            │
│  插件加载器 / 权限框架 / 生命周期管理      │
├──────────────────────────────────────────┤
│            数据层 (Repository)            │
│  豆瓣/TMDB │ QB API │ TR RPC │ CookieCloud│
├──────────────────────────────────────────┤
│            基础设施层                     │
│  dio + 加密存储 + 后台任务 + 状态管理      │
└──────────────────────────────────────────┘
```

### 技术栈

| 层级 | 技术 |
|------|------|
| 框架 | Flutter 3.x（Android / iOS / 鸿蒙） |
| 状态管理 | flutter_riverpod |
| 网络 | dio |
| 设计语言 | Material 3 + 液态玻璃拟态 |
| 插件隔离 | Isolate |

## 📁 项目结构

```
pterpilot/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── theme/                 # 主题系统
│   ├── widgets/               # 通用组件
│   ├── models/                # 数据模型
│   ├── data/                  # Mock 数据
│   ├── providers/             # Riverpod providers
│   ├── services/              # API 服务
│   └── pages/                 # 页面
│       ├── discover/          # 发现页
│       ├── search/            # 聚合搜索
│       ├── detail/            # 影视详情
│       ├── downloader/        # 下载器管理
│       ├── sites/             # 站点管理
│       ├── me/                # 个人中心
│       └── plugins/           # 插件市场
├── docs/
│   ├── plugin-development.md  # 插件开发文档
│   └── harmonyos-build-guide.md  # 鸿蒙构建指南
└── pubspec.yaml
```

## 🤝 贡献

欢迎贡献代码、提交 Issue 或开发插件！

### 贡献代码

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

### 开发规范

- 遵循 [Dart 风格指南](https://dart.cn/guides/language/effective-dart)
- 通过 `flutter analyze` 静态检查
- 新功能建议先开 Issue 讨论

## 📄 许可证

本项目采用 MIT 许可证 — 详见 [LICENSE](LICENSE) 文件。

## ⚠️ 免责声明

- 本项目仅供学习和技术交流使用
- 请遵守所在地区法律法规，不要用于非法用途
- 使用本工具所产生的一切后果由使用者自行承担

---

⭐ 如果这个项目对你有帮助，欢迎点个 Star 支持！
