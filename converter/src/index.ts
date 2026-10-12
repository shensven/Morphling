import colorMatching from "./colorMatching";
import hexToFilter from "./hexToFilter";
import rgbToFilter from "./rgbToFilter";
import hslToFilter from "./hslToFilter";

declare var globalThis: {
  colorMatching: typeof colorMatching;
  hexToFilter: typeof hexToFilter;
  rgbToFilter: typeof rgbToFilter;
  hslToFilter: typeof hslToFilter;
};

globalThis.colorMatching = colorMatching;
globalThis.hexToFilter = hexToFilter;
globalThis.rgbToFilter = rgbToFilter;
globalThis.hslToFilter = hslToFilter;
