import colorMatching from "./colorMatching";
import hexToFilter from "./hexToFilter";

declare var globalThis: {
  colorMatching: typeof colorMatching;
  hexToFilter: typeof hexToFilter;
};

globalThis.colorMatching = colorMatching;
globalThis.hexToFilter = hexToFilter;
