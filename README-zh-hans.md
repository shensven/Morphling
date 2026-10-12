# Morphling

[![GitHub](https://img.shields.io/github/license/shensven/Morphling)](./LICENSE)
[![SwiftLint](https://github.com/shensven/Morphling/actions/workflows/swiftlint.yml/badge.svg?branch=dev)](https://github.com/shensven/Morphling/actions/workflows/swiftlint.yml)
[![Test](https://github.com/shensven/Morphling/actions/workflows/test.yml/badge.svg?branch=dev)](https://github.com/shensven/Morphling/actions/workflows/test.yml)

[English](./README.md) | 简体中文

Morphling 把一个颜色转换成 CSS `filter` 值，用来给单色 SVG 图标改色。

不同开发商的图标包实现方式不同，给图标设置 `fill` 或 `color` 后，未必能得到预期的颜色。CSS `filter` 作用于图标最终渲染出的内容，因此可以强制改成目标颜色。

转换算法来自 JavaScript 项目 [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter)，Morphling 把它带到了 macOS 桌面，做成原生 SwiftUI 应用。

![Preview](./Resources/PressKit/Preview-zh-hans-1.jpg)

## ✨ 特性

- 以 Hex、RGB 或 HSL 输入颜色，切换格式时颜色保持不变
- 可以只复制 filter 值，也可以复制完整的 `filter:` 声明
- 窗口置顶，方便对照浏览器或编辑器使用
- 浅色与深色外观
- English、简体中文、日本語
- 免费且开源

## 💻 系统要求

macOS 14 Sonoma 或更高版本

## 📦 下载

[![Mac App Store](./Resources/AppStoreBadges/Download_on_the_Mac_App_Store_Badge_CNSC_RGB_blk_092917.svg)](https://apps.apple.com/us/app/morphling/id1669993843)

## 🛠 从源码构建

需要 Xcode 26 或更高版本。

1. 打开 `Morphling.xcodeproj`。
2. 在 Signing & Capabilities 中选择你自己的开发团队，或选择 Sign to Run Locally。
3. 构建并运行 Morphling scheme。

如果安装了 [SwiftLint](https://github.com/realm/SwiftLint)，每次构建都会用它检查源码。

在命令行运行测试：

```sh
xcodebuild test -project Morphling.xcodeproj -scheme Morphling -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO
```

颜色转换在 JavaScriptCore 中执行 `converter/dist/converter.js`。这个文件已提交到仓库，所以构建 app 不需要 Node.js。如需修改转换器，请参阅 [converter/README.md](./converter/README.md)。

## 👍 致谢

### 项目依赖

- [color](https://github.com/Qix-/color)
- [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter)

### 美术素材

- 应用图标来自 [3dicons](https://3dicons.co/)，CC0 1.0

### 本地化翻译

- 日本語 - [@kum4423](https://github.com/kum4423)

## 📜 许可证

MIT License - Copyright (c) 2023-2026 DevSven

[Resources/PressKit](./Resources/PressKit) 中的宣传素材采用 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.zh-hans) 许可。
