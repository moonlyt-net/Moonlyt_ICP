import { atom } from "recoil";

export const metadata = atom({
  key: "metadata", // unique ID (with respect to other atoms/selectors)
  default: "", // default value (aka initial value)
});

export const NftModal = atom({
  key: "NftModal",
  default: false,
})