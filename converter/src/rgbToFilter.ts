import CssFilterConverter from "css-filter-converter";

type Props = { r: number; g: number; b: number };

const rgbToFilter = (props: Props) => {
  const { r, g, b } = props;
  const result = CssFilterConverter.rgbToFilter(`${r} ${g} ${b}`);
  return {
    filter: result.color,
  };
};

export default rgbToFilter;
