const ethereumButton = document.querySelector(".enableEthereumButton");

ethereumButton.addEventListener("click", () => {
  //Will Start the metamask extension
  const { ethereum } = window;
  console.log(ethereum, "ethereum");
  if (window.ethereum) {
    console.log("object");
  }
  //   ethereum.request({ method: "eth_requestAccounts" });
});
