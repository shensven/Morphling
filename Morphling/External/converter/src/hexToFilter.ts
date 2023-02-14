import CssFilterConverter from "css-filter-converter";

type HexToFilterParams = Parameters<typeof CssFilterConverter.hexToFilter>;
type HexString = HexToFilterParams["0"];

const hexToFilter = (hexString: HexString) => {
  const result = CssFilterConverter.hexToFilter(hexString);
  return result.color;
};

export default hexToFilter;
