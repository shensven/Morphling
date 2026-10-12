import { defineConfig } from "vite";

// Bundle src/index.ts into one classic script for JavaScriptCore.
// The functions are exposed on globalThis, so the Swift side can call them by name.
export default defineConfig({
  build: {
    // JavaScriptCore on macOS 14 matches Safari 17
    target: "safari17",
    lib: {
      entry: "src/index.ts",
      formats: ["iife"],
      name: "Converter",
      fileName: () => "converter.js",
    },
    outDir: "dist",
    emptyOutDir: true,
  },
});
