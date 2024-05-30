import { useRecoilState } from "recoil";
import { NftModal, metadata } from "../../recoil/meta";

const Headercomponent = () => {
  const [AccountNumber, setAccountNumber] = useRecoilState(metadata);
  const [Modal, setModal] = useRecoilState(NftModal);

  async function requestAccount() {
    console.log("Requesting account...");
    if (window.ethereum) {
      console.log("detected");
      try {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setAccountNumber(accounts[0]);
      } catch (err) {
        console.log("Error connecting...");
      }
    } else {
      console.log("Meta Mask not detected");
    }
  }
  const ModalHandle = () => {
    setModal(!Modal);
  };

  return (
    <div className="flex justify-between h-[100px] max-[1300px]:px-[30px] xl:px-[30px]">
      <a
        href="/"
        className=" text-[#DAFF3F] text-[40px] my-auto cursor-pointer"
      >
        Moonlyt
      </a>
      <div className="flex items-center xl:gap-[150px] text-[24px] max-[600px]:text-[16px] max-[1300px]:gap-[20px] max-[1300px]:hidden">
        <div className=" cursor-pointer " onClick={ModalHandle}>
          Funding
        </div>
        <div
          className=" cursor-pointer "
          onClick={AccountNumber ? null : requestAccount}
        >
          {AccountNumber ? AccountNumber.slice(0, 5) + "..." : "ConnectWallet"}
        </div>
      </div>
    </div>
  );
};

export default Headercomponent;
