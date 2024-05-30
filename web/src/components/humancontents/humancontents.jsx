import Profile from "../../images/ProfileBox.png";

const HumanContents = (props) => {
  const { Images, name, job, color } = props;

  return (
    <div className=" relative flex flex-col xl:max-w-[287px] w-full xl:max-h-[280px] h-full items-center">
      <img
        src={Profile}
        alt="ProfileBox"
        width={287}
        height={345}
        className=" absolute xl:h-[345px] md:w-full h-[calc(100%+20px)]"
      />
      <img
        src={Images}
        alt="humansImage"
        width={234}
        height={232}
        className="mx-auto mt-[38px]"
      />
      <div className=" text-center text-middle">{job}</div>
      <div className={`text-center ${color}`}>{name}</div>
    </div>
  );
};

export default HumanContents;
