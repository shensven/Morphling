import CssFilterConverter from "css-filter-converter";

type Props = { hex: string };

const hexToFilter = (props: Props) => {
  const { hex } = props;
  const result = CssFilterConverter.hexToFilter(hex);
  return {
    filter: result.color,
  };
};

export default hexToFilter;
