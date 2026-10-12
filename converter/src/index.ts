import convertColor from "./convertColor";
import hexToFilter from "./hexToFilter";
import rgbToFilter from "./rgbToFilter";
import hslToFilter from "./hslToFilter";

declare var globalThis: {
  convertColor: typeof convertColor;
  hexToFilter: typeof hexToFilter;
  rgbToFilter: typeof rgbToFilter;
  hslToFilter: typeof hslToFilter;
};

globalThis.convertColor = convertColor;
globalThis.hexToFilter = hexToFilter;
globalThis.rgbToFilter = rgbToFilter;
globalThis.hslToFilter = hslToFilter;
