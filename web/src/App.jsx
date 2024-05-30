import { useRecoilValue } from "recoil";
import Headercomponent from "./components/header/headercomponent";
import FirstContents from "./components/mainfirstcontents/firstcontents";
import MainSecondContents from "./components/mainsecondcontents/mainsecondcontents";
import MainThirdContents from "./components/mainthirdcontents/mainthirdcontents";
import ModalBox from "./components/modal/nftmodal";
import { NftModal } from "./recoil/meta";

function App() {
  const Modal = useRecoilValue(NftModal);

  return (
    <div className=" relative">
      {Modal ? <ModalBox /> : ""}
      <Headercomponent />
      <div className=" xl:px-[30px] flex flex-col xl:gap-[200px] max-[1300px]:gap-[20px]">
        <FirstContents />
        <MainSecondContents />
        <MainThirdContents />
      </div>
    </div>
  );
}

export default App;
