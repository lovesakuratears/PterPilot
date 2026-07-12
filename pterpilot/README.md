# PterPilot — PT 玩家移动端 App

> 基于 Flutter 跨平台框架的 PT 资源一站式管理工具，覆盖 Android / iOS。

## 项目架构

遵循 **PterPilot 移动端架构方案**（详见 `../PterPilot移动端架构方案.md`）：

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
| 框架 | Flutter 3.x | 跨平台（Android / iOS） |
| 状态管理 | flutter_riverpod ^2.4.0 | 编译时安全，适合复杂状态 |
| 网络 | dio ^5.4.0 | HTTP 客户端 |
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

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0

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
```

## 功能模块

### M1 插件系统
- 核心框架 + 内置插件 + 社区插件三层架构
- 插件独立存储空间，权限声明式授权
- 插件市场（已安装/社区）

### M2 下载器管理
- qBittorrent / Transmission 远程控制
- 种子推送、批量操作、状态监控
- 多下载器实例切换

### M3 站点管理
- 多站点聚合管理
- CookieCloud 一键同步
- KPI 数据看板（魔力值/上传量/签到率）
- 登录失效检测

### M4 聚合搜索
- 跨站点并发搜索
- 站点状态实时展示
- 一键推送到下载器

### M5 影视资料与发现
- 豆瓣/TMDB 影视数据
- 热门/Trending/Top250/即将上线
- 详情页一键跳转 PT 搜索

## 设计系统

- **基调**：Material 3 + 液态玻璃拟态
- **品牌种子色**：Teal/Emerald (`#00B4A0`)
- **魔力值语义色**：Violet (`#7C5CFC`)
- **圆角**：卡片 16dp / 按钮全圆 / 底部弹层 28dp
- **间距**：8pt 基线栅格
- **字体**：系统字体栈 + 等宽数值字体

## 数据来源

| 数据源 | 协议 | 状态 |
|--------|------|------|
| 豆瓣电影 | REST API (frodo) | 可用（反爬需处理） |
| TMDB | REST API | 推荐（稳定免费） |
| qBittorrent | Web API | 计划中 |
| Transmission | JSON-RPC | 计划中 |
| CookieCloud | REST API | 计划中 |

> 当前版本使用 Mock 数据演示 UI，豆瓣 API 服务层已搭建，可直接替换。

## 相关文档

- [产品需求文档](../PterPilot_PRD.md)
- [移动端架构方案](../PterPilot移动端架构方案.md)
- [需求分析报告](../PterPilot需求分析报告.md)
- [UI 设计系统](../PterPilot_UI设计系统.md)
