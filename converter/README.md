# Converter

Bundles [color](https://github.com/Qix-/color) and [CSS Filter Converter](https://github.com/OvidijusParsiunas/css-filter-converter) into a single script that Morphling runs in JavaScriptCore.

`src/index.ts` exposes `convertColor`, `hexToFilter`, `rgbToFilter` and `hslToFilter` on `globalThis`. Vite builds it as one IIFE file, `dist/converter.js`, which the Xcode project copies into the app bundle.

## Build

Requires Node.js 20.19+ and pnpm (the version is pinned by `packageManager` in `package.json`).

```sh
pnpm install
pnpm build
```

`pnpm build` type-checks with `tsc`, then writes `dist/converter.js`. Commit the rebuilt `dist/converter.js` together with any source or dependency changes.
