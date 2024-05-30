const CommonButton = (props) => {
  const { text, essential } = props;
  return (
    <div
      className={`${
        essential === true
          ? "bg-black text-white"
          : "bg-white border-solid border-[1px] border-[#e8e8e8] cursor-pointer"
      } text-[20px] h-full max-h-[65px] xl:min-h-[65px] flex items-center justify-center font-light`}
    >
      {text}
    </div>
  );
};

export default CommonButton;
