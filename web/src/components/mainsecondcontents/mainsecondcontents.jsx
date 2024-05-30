import ClickButton from "../button/clickbutton";
import Check from "../../images/check.png";
import Example from "../../images/exampleimage.png";

const MainSecondContents = () => {
  return (
    <div className=" max-[1300px]:px-[30px] xl:flex justify-between mt-[128px] max-[1300px]:max-w-full max-[600px]:mt-[0px] xl:max-w-[1500px] xl:px-[110px] max-[1300px]:mx-auto max-[600px]:px-[36px]">
      <div className="xl:max-w-[509px] h-full w-full ">
        <img
          src={Example}
          alt="ExampleImage"
          className=" max-h-[773px] h-full max-w-[509px] w-full max-[1300px]:mx-auto"
        />
      </div>
      <div className="xl:max-w-[530px] h-full my-auto">
        <div className=" text-large text-fontgray max-[600px]:text-middle max-[600px]:mt-[20px]">
          You can use webtoons to promote author
        </div>
        <div className=" text-title leading-[90px] mt-[30px] mb-[27px] max-[1300px]:text-subTitle max-[600px]:text-[36px] max-[1300px]:leading-[60px] max-[600px]:leading-[40px]">
          The Web 3 development platform.
        </div>
        <div className=" text-large text-fontgray flex xl:mb-[10px] items-center max-[600px]:text-middle">
          <img
            src={Check}
            alt="CheckBoxImage"
            width={28}
            height={28}
            className=" h-[28px] mr-[10px] max-[600px]:h-[18px] max-[600px]:w-[18px]"
          />
          We also plan to add content.
        </div>
        <div className=" text-large text-fontgray flex xl:mb-[30px] items-center max-[600px]:text-middle  max-[600px]:mb-[20px]">
          <img
            src={Check}
            alt="CheckBoxImage"
            width={28}
            height={28}
            className=" h-[28px] mr-[10px] max-[600px]:h-[18px] max-[600px]:w-[18px]"
          />
          We also plan to add content.
        </div>
        <div className=" flex w-full max-[600px]:mx-auto">
          <ClickButton
            text="Try demo"
            onClickHandle="https://moonlyt.vercel.app/"
            mode={"_blank"}
          />
        </div>
      </div>
    </div>
  );
};

export default MainSecondContents;
