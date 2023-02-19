# Morphling

[![GitHub](https://img.shields.io/github/license/shensven/Morphling)](./LICENSE)
[![SwiftLint](https://github.com/shensven/Morphling/actions/workflows/swiftlint.yml/badge.svg?branch=dev)](https://github.com/shensven/Morphling/actions/workflows/swiftlint.yml)
[![Distribution](https://github.com/shensven/Morphling/actions/workflows/distribution.yml/badge.svg?branch=main)](https://github.com/shensven/Morphling/actions/workflows/distribution.yml)
[![Crowdin](https://badges.crowdin.net/morphling/localized.svg)](https://crowdin.com/project/morphling)

[English](./README.md) | 简体中文

起因是，在前端项目中更改单色 svg 图标的颜色，不同开发商的图标包，在添加 CSS 属性 `fill` 或者 `color` 后，可能不会按照预期得到想要的颜色，但是使用 CSS 的 `filter` 属性则可以强制修改。

得感谢 [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter) 这个项目提供了 JavaScript 的算法实现。

我仅将他的 web 实现带到了 macOS 桌面，以原生 SwiftUI 的方式。

![Preview](./Resources/PressKit/Preview-zh-hans-1.jpg)

## ✨ 特性

- [x] 免费且开源
- [x] 通过 JavaScriptCore 使用 npm 包
- [x] 暗黑模式
- [x] 多语言

## 📦 分发方式

[![Mac App Store](./Resources/AppStoreBadges/Download_on_the_Mac_App_Store_Badge_CNSC_RGB_blk_092917.svg)](https://apps.apple.com/us/app/morphling/id1669993843)

如果不能正常下载，那就是 Apple 还在审核，你可以从 TestFlight 先行体验。

https://testflight.apple.com/join/1QM2WgE2

## 👍 致谢

- [color](https://github.com/Qix-/color)
- [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter)
- [LaunchAtLogin-Modern](https://github.com/sindresorhus/LaunchAtLogin-Modern)
- [Remix Icon](https://github.com/Remix-Design/RemixIcon)
- [3dicons](https://3dicons.co/)

## 📜 许可证

MIT License - Copyright (c) 2023 SvenFE
