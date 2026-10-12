import CssFilterConverter from "css-filter-converter";

type Props = { h: number; s: number; l: number };

const hslToFilter = (props: Props) => {
  const { h, s, l } = props;
  const result = CssFilterConverter.hslToFilter(`${h} ${s} ${l}`);
  return {
    filter: result.color,
  };
};

export default hslToFilter;
