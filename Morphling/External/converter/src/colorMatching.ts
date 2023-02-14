import Color from "color";

type ColorParams = Parameters<typeof Color>;

type Props = {
  colorParam: ColorParams["0"];
  colorSpace: ColorParams["1"];
};

const colorMatching = (props: Props) => {
  const { colorParam, colorSpace } = props;

  switch (colorSpace) {
    case "hex":
      try {
        return {
          rgb: Color(colorParam).rgb().object(),
          hsl: Color(colorParam).hsl().object(),
        };
      } catch {
        return undefined;
      }

    case "rgb":
      const rgb = colorParam as { r: number; g: number; b: number };
      const { r, g, b } = rgb;
      try {
        return {
          hex: Color({ r, g, b }).hex(),
          hsl: Color({ r, g, b }).hsl().object(),
        };
      } catch {
        return undefined;
      }

    case "hsl":
      const hsl = colorParam as { h: number; s: number; l: number };
      const { h, s, l } = hsl;
      try {
        return {
          hex: Color({ h, s, l }).hex(),
          rgb: Color({ h, s, l }).rgb().object(),
        };
      } catch {
        return undefined;
      }

    default:
      return undefined;
  }
};

export default colorMatching;
