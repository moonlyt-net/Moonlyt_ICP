import ClickButton from "../button/clickbutton";
import FirstImage from "../../images/firstimage.png";
import SecondImage from "../../images/secondimage.png";
import ThirdImage from "../../images/thirdimage.png";

const FirstContents = () => {
  return (
    <div className="xl:flex justify-between xl:mt-[128px] max-[1300px]:mt-[50px] max-[1300px]:mx-auto">
      <div className="max-w-[488px] max-[1300px]:max-w-full max-[1300px]:px-[30px]">
        <div className=" text-title leading-[90px] max-[1300px]:text-subTitle max-[600px]:text-[36px] max-[1300px]:leading-[60px] max-[600px]:leading-[40px]">
          The Web 3 development platform.
        </div>
        <div className=" text-large mt-[50px] mb-[90px] text-fontgray font-Clinton-Semi font-light max-[1300px]:text-middle max-[600px]:mb-[30px]">
          You can use webtoons to promote author activities or support authors
          by investing in your favorite webtoons.
        </div>
        <div className="flex gap-[20px] max-[600px]:flex-col max-[1300px]:mb-[90px]">
          <ClickButton text="Get Started" onClickHandle="" mode="none" />
          <ClickButton
            text="Docs"
            onClickHandle="https://moonlyt.gitbook.io/moonlyt"
            mode={"_blank"}
          />
        </div>
      </div>
      <div className="xl:flex xl:relative xl:max-w-[835px] xl:max-h-[698px] h-full w-full max-[1300px]:grid max-[1300px]:grid-cols-3 max-[600px]:flex max-[600px]:flex-col max-[1300px]:px-[30px]">
        <img
          src={FirstImage}
          alt="FirstImage"
          width={422}
          height={510}
          className=" xl:absolute xl:animate-FirstImageAnimation max-[1300px]:w-[300px] max-[1300px]:mx-auto"
        />
        <img
          src={SecondImage}
          alt="SecondImage"
          width={419}
          height={539}
          className=" xl:absolute xl:top-[159px] xl:right-[172px] z-10 xl:animate-SecondImageAnimation max-[1300px]:w-[300px] max-[1300px]:mx-auto"
        />
        <img
          src={ThirdImage}
          alt="ThirdImage"
          width={379}
          height={489}
          className=" xl:absolute xl:right-[0px] xl:top-[0px] xl:animate-ThirdImageAnimation max-[1300px]:w-[300px] max-[1300px]:mx-auto"
        />
      </div>
    </div>
  );
};

export default FirstContents;
