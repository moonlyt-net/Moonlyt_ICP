import CommonButton from "./button";

const MissionBox = (props) => {
  const { ButtonData, handlePop } = props;

  return (
    <div className="flex mt-[15px] mb-[10px] w-full gap-[20px]">
      <div className=" flex flex-col w-full  gap-[10px]">
        <div className=" flex  gap-[10px]">
          <div className=" text-[21px] basis-2/3">Activity</div>
          <div className=" text-[21px] basis-1/3">Point</div>
        </div>
        <div className="flex flex-col  gap-[10px]">
          {ButtonData?.map((item, idx) => {
            return (
              <div key={idx} className="flex gap-[10px]">
                <div
                  className={`text-[21px] ${
                    idx !== 0 ? "basis-3/5" : "basis-2/3"
                  }`}
                >
                  <CommonButton
                    text={item.title}
                    essential={idx === 0 ? true : false}
                  />
                </div>
                <div
                  className={`text-[21px] ${
                    idx !== 0 ? "basis-1/5" : "basis-1/3"
                  }`}
                >
                  <CommonButton
                    text={item.value}
                    essential={idx === 0 ? true : false}
                  />
                </div>
                {idx !== 0 ? (
                  <div
                    className={` cursor-pointer text-[21px] flex items-center justify-center border-solid border-[1px] border-[#e8e8e8] w-full basis-1/5`}
                    onClick={() => handlePop(item.title)}
                  >
                    -
                  </div>
                ) : null}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default MissionBox;
