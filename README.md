# Morphling

[![GitHub](https://img.shields.io/github/license/shensven/Morphling)](./LICENSE)
[![SwiftLint](https://github.com/shensven/Morphling/actions/workflows/swiftlint.yml/badge.svg?branch=dev)](https://github.com/shensven/Morphling/actions/workflows/swiftlint.yml)
[![Test](https://github.com/shensven/Morphling/actions/workflows/test.yml/badge.svg?branch=dev)](https://github.com/shensven/Morphling/actions/workflows/test.yml)

English | [简体中文](./README-zh-hans.md)

Morphling turns a color into a CSS `filter` value that recolors monochrome SVG icons.

Depending on how an icon pack is built, setting `fill` or `color` on its icons may not give you the color you expect. A CSS `filter` recolors whatever the icon renders, so it works regardless.

The conversion comes from [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter), a JavaScript project. Morphling brings it to the Mac as a native SwiftUI app.

![Preview](./Resources/PressKit/Preview-en-1.jpg)

## ✨ Features

- Enter a color as Hex, RGB or HSL, and switch between them without losing it
- Copy the filter on its own or as a complete `filter:` declaration
- Keep the window on top while you work in a browser or editor
- Light and dark appearance
- English, 简体中文 and 日本語
- Free and open source

## 💻 Requirements

macOS 14 Sonoma or later

## 📦 Download

[![Mac App Store](./Resources/AppStoreBadges/Download_on_the_Mac_App_Store_Badge_US-UK_RGB_blk_092917.svg)](https://apps.apple.com/us/app/morphling/id1669993843)

## 🛠 Building from Source

Requires Xcode 26 or later.

1. Open `Morphling.xcodeproj`.
2. Under Signing & Capabilities, pick your own team, or choose Sign to Run Locally.
3. Build and run the Morphling scheme.

If [SwiftLint](https://github.com/realm/SwiftLint) is installed, every build lints the sources with it.

To run the tests from the command line:

```sh
xcodebuild test -project Morphling.xcodeproj -scheme Morphling -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO
```

The conversion runs in JavaScriptCore from `converter/dist/converter.js`. That file is committed, so building the app doesn't need Node.js. To change the converter, see [converter/README.md](./converter/README.md).

## 👍 Credits

### Dependencies

- [color](https://github.com/Qix-/color)
- [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter)

### Artwork

- App icon from [3dicons](https://3dicons.co/), CC0 1.0

### Localization

- 日本語 - [@kum4423](https://github.com/kum4423)

## 📜 License

MIT License - Copyright (c) 2023-2026 DevSven

The press kit in [Resources/PressKit](./Resources/PressKit) is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
