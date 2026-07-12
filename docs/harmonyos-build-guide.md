# 鸿蒙（HarmonyOS / OpenHarmony）构建指南

PterPilot 支持鸿蒙平台。基于 Flutter OpenHarmony 移植版构建，可运行在 HarmonyOS NEXT 及 OpenHarmony 设备上。

## 环境要求

| 项目 | 要求 |
|------|------|
| Flutter OHOS | >= 3.27.0 |
| Dart SDK | >= 3.6.0 |
| OpenHarmony SDK | API 12+ |
| DevEco Studio | 5.0+ |
| Node.js | >= 18.0 |

## 安装 Flutter OHOS

### 方式一：使用官方移植版

```bash
# 克隆 OpenHarmony Flutter 移植仓库
git clone https://gitee.com/openharmony-sig/flutter_flutter.git -b 3.27.0-ohos
cd flutter_flutter

# 设置环境变量
export PATH="$PATH:`pwd`/bin"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# 验证安装
flutter --version
flutter doctor
```

### 方式二：使用国内镜像（推荐）

```bash
# 设置镜像
export FLUTTER_GIT_URL=https://gitee.com/openharmony-sig/flutter_flutter.git

# 下载 ohos 版 flutter
git clone -b 3.27.0-ohos https://gitee.com/openharmony-sig/flutter_flutter.git
```

## 获取 OpenHarmony SDK

```bash
# 通过 DevEco Studio SDK Manager 下载
# 或使用命令行工具
sdkmanager --sdk_root=$OHOS_SDK_ROOT "platforms;api-12" "toolchains;3.2.11.6"
```

设置环境变量：

```bash
export OHOS_SDK_ROOT=/path/to/ohos/sdk
export PATH="$PATH:$OHOS_SDK_ROOT/toolchains/3.2.11.6"
```

## 项目配置

### 1. 初始化鸿蒙平台

```bash
cd pterpilot

# 创建 ohos 平台目录
flutter create --platforms=ohos .
```

### 2. 应用签名配置

在 `ohos/AppScope/app.json5` 中配置应用信息：

```json5
{
  "app": {
    "bundleName": "com.pterpilot.app",
    "vendor": "pterpilot",
    "versionCode": 1000,
    "versionName": "0.1.0",
    "icon": "$media:app_icon",
    "label": "$string:app_name"
  }
}
```

### 3. 权限配置

在 `ohos/entry/src/main/module.json5` 中添加所需权限：

```json5
{
  "module": {
    "name": "entry",
    "type": "entry",
    "requestPermissions": [
      {
        "name": "ohos.permission.INTERNET",
        "reason": "$string:internet_permission_reason"
      },
      {
        "name": "ohos.permission.READ_MEDIA",
        "reason": "$string:media_permission_reason"
      },
      {
        "name": "ohos.permission.WRITE_MEDIA",
        "reason": "$string:media_permission_reason"
      },
      {
        "name": "ohos.permission.NOTIFICATION_CONTROLLER",
        "reason": "$string:notification_permission_reason"
      }
    ]
  }
}
```

## 构建应用

```bash
# Debug 构建
flutter build hap --debug

# Release 构建
flutter build hap --release

# 指定 target platform
flutter build hap --release --target-platform=arm64-v8a
```

构建产物路径：
- Debug: `build/ohos/debug/`
- Release: `build/ohos/release/`

## 安装运行

```bash
# 连接设备或启动模拟器
hdc list targets

# 安装 hap
hdc install build/ohos/release/pterpilot-default-signed.hap

# 启动应用
hdc shell aa start -a EntryAbility -b com.pterpilot.app
```

## 依赖兼容性

项目仅依赖纯 Dart 库，鸿蒙平台原生兼容，无需额外适配：

| 依赖 | 鸿蒙支持 | 说明 |
|------|---------|------|
| flutter_riverpod | ✅ 原生支持 | 纯 Dart 状态管理 |
| dio | ✅ 原生支持 | 纯 Dart 网络库 |
| cupertino_icons | ✅ 原生支持 | 资源包，无平台代码 |

> 已移除 `google_fonts`、`cached_network_image`、`shimmer`、`intl` 等在鸿蒙上存在兼容风险的依赖。图片加载使用 Flutter 原生 `Image.network`，字体使用系统默认字体。

### 后续如需添加平台相关依赖

| 需求 | 鸿蒙推荐 |
|------|---------|
| 加密存储 | `ohos_keystore` 插件 |
| 文件路径 | `path_provider_ohos` |
| 本地通知 | `ohos_notification` 插件 |

### 平台判断示例

```dart
import 'package:flutter/foundation.dart';

// 判断是否运行在鸿蒙平台
bool get isOhos => defaultTargetPlatform == TargetPlatform.ohos;

// 按平台选择字体
String get platformFont {
  if (isOhos) return 'HarmonyOS Sans';
  if (defaultTargetPlatform == TargetPlatform.android) return 'Roboto';
  if (defaultTargetPlatform == TargetPlatform.iOS) return 'SF Pro';
  return 'Roboto';
}
```

## 平台差异化处理

### 判断运行平台

```dart
import 'dart:io';

bool get isHarmonyOS => Platform.isOhos;

// 或使用 defaultTargetPlatform
import 'package:flutter/foundation.dart';

bool get isOhos => defaultTargetPlatform == TargetPlatform.ohos;
```

### 平台专属功能

```dart
Widget buildPlatformButton(BuildContext context) {
  return Platform.isOhos
      ? _buildHarmonyButton(context)
      : _buildMaterialButton(context);
}
```

## 已知限制

1. **WebView**：鸿蒙 WebView 组件与 Android/iOS API 不一致，需单独适配
2. **原生插件**：多数第三方插件尚未支持鸿蒙，需自行移植或寻找替代
3. **通知**：鸿蒙通知系统接口不同，需使用 `ohos_notification` 插件
4. **后台服务**：鸿蒙后台任务受严格限制，需使用 Work Scheduler
5. **签名**：正式发布需华为/OpenHarmony 应用签名证书

## 调试

```bash
# 运行 Debug 版本
flutter run -d ohos

# 查看日志
hdc hilog | grep flutter

# DevTools 调试
flutter run -d ohos --start-paused
```

## 发布到应用市场

### 华为应用市场（AppGallery）
1. 注册华为开发者账号
2. 创建应用，填写应用信息
3. 上传签名后的 HAP 包
4. 提交审核

### OpenHarmony 应用市场
1. 注册 OpenHarmony 社区开发者
2. 签署开发者协议
3. 上传应用，等待社区审核

## 参考资源

- [Flutter OpenHarmony 移植](https://gitee.com/openharmony-sig/flutter_flutter)
- [OpenHarmony 开发文档](https://gitee.com/openharmony/docs)
- [DevEco Studio 下载](https://developer.huawei.com/consumer/cn/deveco-studio/)
