const Textinput = (props) => {
  const { textcontents, inputcotents, handleChange, placeholder, name } = props;

  return (
    <div className="flex justify-between mb-[33px] max-h-[53px] h-full items-center">
      <div className="max-w-[200px] w-full text-[21px]">{textcontents}</div>
      <input
        value={inputcotents}
        onChange={handleChange}
        placeholder={placeholder}
        name={name}
        className=" outline-none w-full border-[#E8E8E8] border-solid border-[1px] h-full pl-[14px] py-[18px] font-light"
      />
    </div>
  );
};

export default Textinput;
