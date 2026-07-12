# PterPilot — PT 玩家移动端 App

> 基于 Flutter 跨平台框架的 PT 资源一站式管理工具，覆盖 Android / iOS / 鸿蒙。

## 项目架构

```
┌──────────────────────────────────────────┐
│            UI 层 (Flutter Widgets)        │
│  5 Tab(发现/搜索/下载器/站点/我的) + 插件   │
├──────────────────────────────────────────┤
│          业务逻辑层 (Riverpod)             │
│  DownloaderService │ SiteService │ ...    │
├──────────────────────────────────────────┤
│            数据层 (Dio Client)             │
│  豆瓣/TMDB │ qBittorrent │ CookieCloud    │
└──────────────────────────────────────────┘
```

### 技术栈

| 层级 | 技术 | 说明 |
|------|------|------|
| 框架 | Flutter 3.27+ | 跨平台（Android / iOS / 鸿蒙） |
| 状态管理 | flutter_riverpod ^2.6.1 | 编译时安全，适合复杂状态 |
| 网络 | dio ^5.7.0 | HTTP 客户端 |
| 设计语言 | Material 3 + 液态玻璃拟态 | Teal/Emerald 种子色 |
| 双主题 | Light / Dark | 深浅主题独立调色板 |

### 目录结构

```
lib/
├── main.dart                  # 应用入口
├── theme/
│   ├── app_colors.dart        # 色彩系统（Light/Dark）
│   └── app_theme.dart         # Material 3 主题配置
├── widgets/
│   └── glass_widgets.dart     # 玻璃拟态通用组件
├── models/
│   └── models.dart            # 数据模型（Movie/Site/Torrent等）
├── data/
│   └── mock_data.dart         # Mock 数据（离线演示用）
├── providers/
│   └── app_providers.dart     # Riverpod 状态提供者
├── services/
│   └── douban_service.dart    # 豆瓣 API 服务
└── pages/
    ├── home_scaffold.dart     # 底部导航框架
    ├── discover/              # 发现页
    ├── search/                # 聚合搜索页
    ├── detail/                # 影视详情页
    ├── downloader/            # 下载器页
    ├── sites/                 # 站点管理页
    ├── me/                    # 我的页
    └── plugins/               # 插件市场页
```

## 快速开始

### 环境要求

- Flutter SDK >= 3.27.0
- Dart SDK >= 3.6.0

### 安装运行

```bash
cd pterpilot
flutter pub get
flutter run
```

### 构建

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# 鸿蒙
flutter build hap --release
```

## 相关文档

- [插件开发文档](../docs/plugin-development.md)
- [鸿蒙构建指南](../docs/harmonyos-build-guide.md)
