/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      animation: {
        FirstImageAnimation: "ImageUpDown 2s linear 0s infinite alternate;",
        SecondImageAnimation: "SecondUpDown 3s linear 0s infinite alternate;",
        ThirdImageAnimation: "ThirdUpDown 4s linear 0s infinite alternate;",
      },
      keyframes: {
        ImageUpDown: {
          from: { top: `0px` },
          to: { top: `50px` },
        },
        SecondUpDown: {
          from: { top: `159px` },
          to: { top: `209px` },
        },
        ThirdUpDown: {
          from: { top: `0px` },
          to: { top: `50px` },
        },
      },
      backgroundImage: {
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",
        "gradient-conic":
          "conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))",
      },
      fontSize: {
        middle: "18px",
        large: "24px",
        subTitle: "55px",
        title: "77px",
      },
      textColor: {
        fontgray: "#cccccc",
      },
    },
    fontFamily: {
      "Clinton-Semi": ["Clinton-Semi"],
      "Clinton-Bold": ["Clinton-Bold"],
    },
  },
  plugins: [],
};

