import CssFilterConverter from "css-filter-converter";

type HexToFilterParams = Parameters<typeof CssFilterConverter.hexToFilter>;
type HexString = HexToFilterParams["0"];

type HexToFilter = typeof hexToFilter;
declare var globalThis: {
  hexToFilter: HexToFilter;
};

const hexToFilter = (hexString: HexString) => {
  const result = CssFilterConverter.hexToFilter(hexString);
  return result.color;
};

globalThis.hexToFilter = hexToFilter;
