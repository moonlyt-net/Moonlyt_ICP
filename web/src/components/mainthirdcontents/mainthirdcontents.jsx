import HumanContents from "../humancontents/humancontents";
import Jay from "../../images/jay.png";
import Ashimo from "../../images/ashimo.png";
import Simpson from "../../images/simpson.png";
import Sol from "../../images/sol.png";

const MainThirdContents = () => {
  return (
    <div className=" xl:mb-[231px] max-[1300px]:max-w-full max-[1300px]:px-[30px] w-full">
      <div className=" text-subTitle mb-[50px] max-[700px]:w-full max-[600px]:text-[36px] max-[350px]:text-[30px]">
        TEAM Moonlyt
      </div>
      <div className=" flex justify-between max-[700px]:flex-col max-[700px]:gap-[50px] w-full">
        <HumanContents
          Images={Jay}
          name="Jay"
          job="Smart Contract"
          color="text-[#38F934]"
        />
        <HumanContents
          Images={Ashimo}
          name="Ashimo"
          job="Back-End"
          color="text-[#FFA5A5]"
        />
        <HumanContents
          Images={Simpson}
          name="Simpson"
          job="Front-End"
          color="text-[#E7FF57]"
        />
        <HumanContents
          Images={Sol}
          name="Sol"
          job="Designer"
          color="text-[#12FFFF]"
        />
      </div>
    </div>
  );
};

export default MainThirdContents;
