import { useRef, useState } from "react";
import Textinput from "./components/textinput/textinput";
import { useRecoilValue, useSetRecoilState } from "recoil";
import { NftModal, metadata } from "../../recoil/meta";
import Plus from "../../images/plus.png";
import MissionBox from "./components/missionbox/missionbox";
import AWS from "aws-sdk";
import imageCompression from "browser-image-compression";
// import axios from "axios";

const ModalBox = () => {
  const Account = useRecoilValue(metadata);
  const setModal = useSetRecoilState(NftModal);
  const REGION = import.meta.env?.VITE_APP_REGION;
  const ACESSKEY = import.meta.env?.VITE_APP_ACCESS_KEY_ID;
  const SECRETKEY = import.meta.env?.VITE_APP_SECRET_ACCESS_KEY_ID;

  const [ButtonData, setButtonData] = useState([
    {
      title: "출석체크",
      value: 300,
    },
  ]);
  const [SaveInput, setSaveInput] = useState(false);
  const [SubBtnData, setSubBtnData] = useState({
    title: "",
    value: "",
  });
  const [Data, setData] = useState({
    name: "",
    price: "",
    limit: "",
    benefit: "",
    discription: "",
    Images: [],
  });
  const ClickRef = useRef();

  const handleCloseModal = (e) => {
    if (e.target.classList.contains("box-close")) {
      return setModal(false);
    }
    return;
  };

  const handleInputChange = () => {
    setSaveInput((prev) => !prev);
  };

  const handleonChangeBtnData = (e) => {
    const { name, value } = e.target;

    setSubBtnData((prev) => ({
      ...prev,
      [name]: name === "title" ? value : +value,
    }));
  };

  const handleCreateBtn = () => {
    if (SubBtnData.title.length === 0 || SubBtnData.value.length === 0) {
      alert("모두다 적어주세요");
    } else {
      setButtonData((prev) => [...prev, SubBtnData]);
      setSubBtnData({
        title: "",
        value: "",
      });
      handleInputChange();
    }
  };

  const uploadS3 = (imageFile) => {
    AWS.config.update({
      region: REGION,
      apiVersion: "latest",
      maxRetries: 3,
      httpOptions: { timeout: 30000, connectTimeout: 5000 },
      credentials: {
        accessKeyId: ACESSKEY,
        secretAccessKey: SECRETKEY,
      },
    });
    const s3 = new AWS.S3();

    // 업로드할 파일 정보 설정
    const uploadParams = {
      Bucket: "moonlyt", // 버킷 이름 변경
      Key: `upload/${imageFile.name}`, // S3에 저장될 경로와 파일명
      Body: imageFile,
    };

    s3.upload(uploadParams, (err, data) => {
      if (err) {
        console.error("Error uploading file:", err);
      } else {
        console.log("File uploaded successfully. ETag:", data.ETag);
      }
    });
  };

  const blobToImage = (blob) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();

      reader.onloadend = () => {
        setData((prev) => ({
          ...prev,
          Images: [...prev.Images, reader.result],
        }));
      };

      reader.onerror = reject;
      reader.readAsDataURL(blob);
    });
  };

  const onchangeImageUpload = async (e) => {
    const { files } = e.target;
    const uploadFile = files[0];

    if (uploadFile.size / (1024 * 1024) >= 15) {
      return alert("15MB 미만의 이미지 크기만 올려주세요!");
    }
    try {
      const options = {
        maxSizeMB: 1, // 압축 후 파일 크기 제한 (MB)
        maxWidthOrHeight: 1920, // 이미지 너비 또는 높이 제한
        useWebWorker: true, // 웹 워커 사용 여부
      };
      const compressedFile = await imageCompression(uploadFile, options);

      blobToImage(compressedFile);

      uploadS3(compressedFile);
    } catch (error) {
      console.log(error);
    }
  };

  const handleChange = (e) => {
    const { id, name, value } = e.target;
    if (!id) {
      setData((prev) => ({
        ...prev,
        [name]: value,
      }));
    } else {
      ClickRef.current.click();
    }
  };

  const handlePop = (title) => {
    const data = ButtonData.filter((item) => item.title !== title);
    setButtonData(data);
  };

  // ICP핸들러입니다.
  const handleSubmit = () => {
    // icpConnect 코드를 넣어주세요~!
    if (
      Data.Images.length === 0 ||
      Data.benefit.length === 0 ||
      Data.limit.length === 0 ||
      Data.name.length === 0 ||
      Data.price.length === 0 ||
      Data.discription.length === 0
    ) {
      alert("Please, Contents Write!");
    } else if (Account.length === 0) {
      alert("Please, Wallet Connect!");
    } else {
      // hear code push please
      const Images = Data.Images.map((item, idx) => {
        return {
          img_name: `Image${idx}`,
          content: item,
        };
      });
      const UserData = {
        metadata: {
          name: Data.name,
          description: Data.discription,
          price: +Data.price,
        },
        owner: Account,
        author: Account,
        images: Images,
      };

      console.log(UserData);

      // 여기 api 바꿔주시면 됩니다.
      // axios
      //   .post(
      //     `https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.icp0.io/?id=g6lmk-eiaaa-aaaao-a3kwq-cai/nfts`,
      //     UserData
      //   )
      //   .then(() => {
      //     alert("Success!!");
      //   });
    }
  };

  return (
    <div className=" w-full h-full absolute">
      <div
        className=" bg-slate-400/25  fixed w-full h-screen flex items-center justify-center z-30 py-[30px] box-close"
        onClick={handleCloseModal}
      >
        <div className=" max-w-[1000px] w-full bg-white h-full overflow-y-scroll p-[34px] text-black">
          <div className=" text-[35px] mb-[37px]">Create NFT</div>
          <Textinput
            textcontents="Webtoon Name"
            inputcotents={Data.name}
            handleChange={handleChange}
            placeholder="Please write Webtoon’s name!"
            name="name"
          />
          <Textinput
            textcontents="Price"
            inputcotents={Data.price}
            handleChange={handleChange}
            placeholder="Please set the limited number of NFTs!"
            name="price"
          />
          <Textinput
            textcontents="Limited Quantity"
            inputcotents={Data.limit}
            handleChange={handleChange}
            placeholder="Please set the limited number of NFTs!"
            name="limit"
          />
          <div className=" border-[#686868] border-solid border-[1.5px] mb-[33px]" />
          <Textinput
            textcontents="Benefit"
            inputcotents={Data.benefit}
            handleChange={handleChange}
            placeholder="Please set NFT purchase benefits!"
            name="benefit"
          />
          <Textinput
            textcontents="Discription"
            inputcotents={Data.discription}
            handleChange={handleChange}
            placeholder="Please write Webtoon’s Discription"
            name="discription"
          />
          <div className="flex justify-between mb-[33px] items-center text-black min-h-[266px]">
            <div className="max-w-[200px] w-full text-[21px]">NFT IMAGE</div>
            <div className=" grid xl:grid-cols-3 gap-x-[25px] gap-y-[20px] w-full h-full min-h-[266px]">
              {Data.Images.map((items, idx) => {
                return (
                  <div
                    key={idx}
                    className=" border-[#E8E8E8] border-solid border-[1px] max-w-[233px] max-h-[266px] flex items-center justify-center w-full h-full cursor-pointer"
                  >
                    <img src={items} alt="Plus-Btn" />
                  </div>
                );
              })}
              {Data.Images.length !== 6 ? (
                <div
                  className=" border-[#E8E8E8] border-solid border-[1px] max-w-[233px] max-h-[266px] flex items-center justify-center w-full h-full cursor-pointer"
                  onClick={handleChange}
                  id="Images"
                >
                  <img src={Plus} alt="Plus-Btn" onClick={handleChange} />
                </div>
              ) : null}
              <input
                type="file"
                ref={ClickRef}
                className="hidden"
                onChange={onchangeImageUpload}
              />
            </div>
          </div>
          <MissionBox ButtonData={ButtonData} handlePop={handlePop} />
          {SaveInput ? (
            <div className=" mb-[20px] xl:h-[65px] w-full h-full max-h-[65px] flex gap-[20px]">
              <input
                name="title"
                value={SubBtnData.title}
                onChange={handleonChangeBtnData}
                className="bg-white border-solid border-[1px] border-[#e8e8e8] w-full basis-1/3 pl-[10px]"
              />
              <input
                name="value"
                type="number"
                value={SubBtnData.value}
                onChange={handleonChangeBtnData}
                className="bg-white border-solid border-[1px] border-[#e8e8e8] w-full basis-1/3 pl-[10px] appearance-none"
              />
              <div
                className="bg-black text-white cursor-pointer basis-1/3 text-[20px] flex items-center justify-center"
                onClick={handleCreateBtn}
              >
                Create
              </div>
            </div>
          ) : null}
          <div
            className=" mb-[20px] cursor-pointer bg-white border-solid border-[1px] border-[#e8e8e8] xl:h-[65px] w-full max-h-[65px] h-full flex items-center justify-center"
            onClick={handleInputChange}
          >
            <img src={Plus} alt="DataAddImage" className="w-[52px] h-[52px]" />
          </div>
          <div className=" text-black w-full">
            <div
              className=" mx-auto w-[200px] h-[50px] bg-black text-white flex items-center justify-center rounded-[10px] hover:text-black hover:bg-white hover:border-solid hover:border-[1px] hover:border-black cursor-pointer"
              onClick={handleSubmit}
            >
              Submit
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ModalBox;
