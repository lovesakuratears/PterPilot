# 插件开发文档

## 概述

PterPilot 的所有功能模块都以插件形式存在。核心框架仅提供基础能力（网络通信、本地存储、路由导航、插件加载器），功能模块通过插件方式接入。开发者可以为 PterPilot 开发自定义插件，并发布到社区供他人使用。

## 插件架构

```
┌─────────────────────────────────────────┐
│              PterPilot 核心框架          │
│  网络通信 / 存储 / 路由 / 插件加载器      │
├─────────────┬─────────────┬─────────────┤
│  内置插件    │  内置插件    │  社区插件    │
│ 下载器管理   │ 站点管理     │ 自定义功能   │
│ 聚合搜索     │ 影视资料     │             │
└─────────────┴─────────────┴─────────────┘
```

### 核心能力

核心框架暴露给插件的能力：

| 能力 | API | 说明 |
|------|-----|------|
| 网络请求 | `PterPilot.http` | 封装的 Dio 实例，自动处理 Cookie/UA |
| 本地存储 | `PterPilot.storage` | 插件独立的键值存储，数据隔离 |
| 路由导航 | `PterPilot.nav` | 页面跳转、底部导航注册 |
| 下载器控制 | `PterPilot.downloader` | 推送种子、获取任务列表 |
| 站点数据 | `PterPilot.sites` | 读取站点列表、Cookie |
| 通知 | `PterPilot.notify` | 本地通知、Toast |
| 定时任务 | `PterPilot.schedule` | 后台定时任务 |

## 快速开始

### 环境要求

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0

### 创建第一个插件

```bash
# 1. 创建插件包目录
mkdir -p pterpilot_plugins/my_plugin/lib
cd pterpilot_plugins/my_plugin
```

### 插件目录结构

```
my_plugin/
├── plugin.yaml              # 插件声明文件（必填）
├── pubspec.yaml             # Dart 包配置
├── lib/
│   ├── my_plugin.dart       # 插件入口
│   └── src/
│       ├── service.dart     # 业务逻辑
│       └── pages/           # 页面组件
└── assets/                  # 资源文件（可选）
```

## plugin.yaml 声明

```yaml
name: my_plugin
version: 0.1.0
author: your_name
description: 插件功能的一句话描述
homepage: https://github.com/your-name/pterpilot-plugin

# 最低兼容的 App 版本
min_app_version: "0.1.0"

# 权限声明（用户启用时授权）
permissions:
  - network          # 网络访问
  - storage_read     # 读取本地存储
  - storage_write    # 写入本地存储
  - downloader       # 控制下载器
  - sites_read       # 读取站点数据
  - notification     # 发送通知

# 导航入口声明
navigation:
  # 侧边栏入口
  sidebar:
    icon: sparkles
    label: 我的插件
    route: /my_plugin/home
  
  # 底部导航栏入口（可选，最多 1 个）
  bottom_nav:
    icon: star
    active_icon: star_fill
    label: 插件
    route: /my_plugin/home

# 定时任务声明（可选）
scheduled_tasks:
  - id: my_daily_task
    interval: 86400    # 秒，24小时
    entry: dailySync

# 入口函数
entry:
  main: MyPlugin      # 插件主类
```

## 插件代码模板

```dart
import 'package:pterpilot_core/pterpilot_core.dart';

class MyPlugin extends PterPilotPlugin {
  @override
  String get name => 'my_plugin';

  @override
  String get version => '0.1.0';

  @override
  void onInstall() {
    // 插件安装时调用
  }

  @override
  void onEnable() {
    // 插件启用时调用
    // 注册路由、定时任务等
    nav.registerRoute('/my_plugin/home', (context) => MyPluginHomePage());
  }

  @override
  void onDisable() {
    // 插件禁用时调用
    // 清理资源、注销定时任务
  }

  @override
  void onUninstall() {
    // 插件卸载时调用
    // 清空本地存储
    storage.clear();
  }

  /// 定时任务入口
  Future<void> dailySync() async {
    // 执行定时任务逻辑
  }
}
```

## 核心 API 使用

### 网络请求

```dart
// GET 请求
final response = await http.get('https://example.pt/torrents.php');

// POST 请求
final resp = await http.post(
  'https://example.pt/takeupload.php',
  data: {'title': '...'},
);

// 使用站点的 Cookie 和 UA 发送请求
final siteResp = await http.withSite('馒头PT').get('/torrents.php');
```

### 本地存储

```dart
// 写入
await storage.setString('api_key', 'xxx');
await storage.setInt('count', 42);

// 读取
final apiKey = storage.getString('api_key');
final count = storage.getInt('count') ?? 0;

// 删除
storage.remove('api_key');

// 清空（仅当前插件数据）
storage.clear();
```

### 下载器控制

```dart
// 获取下载器列表
final downloaders = await downloader.list();

// 推送种子
await downloader.pushTorrent(
  downloaderId: 'home_nas',
  torrentUrl: 'https://site.pt/download.php?id=123',
  category: '电影',
  savePath: '/downloads/movies',
);

// 获取任务列表
final tasks = await downloader.getTasks(downloaderId: 'home_nas');
```

### 站点数据

```dart
// 获取所有站点
final siteList = sites.all();

// 获取单个站点配置
final site = sites.get('馒头PT');

// 使用站点 Cookie 发起请求
final cookie = site.cookie;
final userAgent = site.userAgent;
```

### 通知

```dart
// Toast 提示
notify.toast('同步完成');

// 本地通知
notify.show(
  title: 'Cookie 失效',
  body: '馒头PT 登录已过期，请重新登录',
  actions: [
    NotificationAction(label: '去更新', route: '/sites'),
  ],
);
```

### 路由导航

```dart
// 跳转页面
nav.push('/my_plugin/detail', arguments: {'id': '123'});

// 返回
nav.pop();

// 跳转到 Tab 页
nav.goToTab(TabIndex.discover);
```

## 站点适配

### 支持的站点架构

| 架构 | 支持程度 | 说明 |
|------|---------|------|
| NexusPHP | ✅ 完整 | 主流架构，覆盖 80%+ 站点 |
| Tnode | ⚠️ 部分 | Cookie 不会失效，需额外 Token |
| mTorrent | ⚠️ 部分 | 基础功能支持 |
| Gazelle | 🔮 计划 | 如 RED、PTH 等音乐站 |

### 站点插件模板

```dart
class MySitePlugin extends SitePlugin {
  @override
  String get siteType => 'nexusphp';

  // 解析种子列表
  @override
  List<TorrentInfo> parseTorrents(String html) {
    // 解析 HTML 返回种子列表
  }

  // 解析用户信息
  @override
  UserInfo parseUserInfo(String html) {
    // 解析上传量、下载量、魔力值等
  }

  // 构建搜索 URL
  @override
  String buildSearchUrl(String keyword, Map<String, dynamic> params) {
    return '/torrents.php?search=$keyword';
  }
}
```

## 插件分类

### 功能型插件
- 扩展 App 功能，如站点签到、数据看板、RSS 订阅等
- 注册导航入口，提供完整页面

### 站点型插件
- 适配特定 PT 站点架构
- 提供种子搜索、用户信息解析能力
- 可被聚合搜索调用

### 下载器插件
- 适配特定下载器（如 qBittorrent、Transmission、Download Station）
- 提供种子推送、任务管理能力

## 发布到社区

### 提交要求

1. 开源协议：推荐 MIT / GPL-3.0
2. 代码质量：通过 `flutter analyze`，无警告
3. 文档完善：包含 README.md 和使用说明
4. 安全合规：不含恶意代码，不收集用户数据

### 发布流程

1. 将插件发布到 GitHub / GitLab
2. 在 `plugin.yaml` 中填写正确的版本和描述
3. 在社区仓库提交 PR 或 Issue 申请收录
4. 审核通过后出现在插件市场

## 调试开发

```bash
# 在 App 中加载本地插件进行调试
# 在 App 的 pubspec.yaml 中添加依赖
dependencies:
  my_plugin:
    path: ../pterpilot_plugins/my_plugin

# 热重载调试
flutter run
```

## 常见问题

**Q: 插件之间数据互通吗？**
A: 不互通。每个插件有独立的存储空间，互相隔离。

**Q: 插件崩溃会影响主 App 吗？**
A: 不会。插件运行在独立 Isolate 中，崩溃会被自动捕获并禁用插件。

**Q: 可以调用其他插件的功能吗？**
A: 暂不支持。插件间功能隔离，避免耦合。

**Q: 支持付费插件吗？**
A: 插件市场本身不提供支付功能，但你可以自行设置付费方式。

## 版本兼容

| App 版本 | 插件 API 版本 |
|----------|-------------|
| 0.1.x    | v1          |

---

有问题？请在 GitHub Discussions 或社区频道提问。
