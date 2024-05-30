const ClickButton = ({ text, onClickHandle, mode }) => {
  const handleClick = () => {
    alert("This button is under development");
  };

  return mode === "none" ? (
    <div
      onClick={handleClick}
      className=" max-[600px]:w-[160px] max-[600px]:h-[40px] max-[600px]:text-middle font-Clinton-Bold text-[24px] hover:cursor-pointer w-[243px] h-[55px]  bg-[#ffffff] hover:bg-[#000] text-[#000000] hover:text-[#ffffff] border-solid border-[#ffffff] border-[1px] rounded-[6px] flex items-center justify-center "
    >
      {text}
    </div>
  ) : (
    <a
      className=" max-[600px]:w-[160px] max-[600px]:h-[40px] max-[600px]:text-middle font-Clinton-Bold text-[24px] hover:cursor-pointer w-[243px] h-[55px]  bg-[#ffffff] hover:bg-[#000] text-[#000000] hover:text-[#ffffff] border-solid border-[#ffffff] border-[1px] rounded-[6px] flex items-center justify-center "
      href={onClickHandle}
      target={mode}
    >
      {text}
    </a>
  );
};

export default ClickButton;
