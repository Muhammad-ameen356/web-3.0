import "hardhat/console.sol";
import { ethers } from "hardhat";

describe("StoreCarData", function () {
  let storeCarData;
  let owner;
  let addr1;
  let addr2;

  const CAR_NUMBER = "ABC123";
  const NAME_OF_CAR = "Tesla Model S";
  const COLOR = "Red";
  const YEAR = 2022;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    const StoreCarData = await ethers.getContractFactory("StoreCarData");
    storeCarData = await StoreCarData.deploy();
    await storeCarData.deployed();
  });

  it("should allow owner to store car details", async function () {
    await storeCarData
      .connect(owner)
      .storeCarDetails(CAR_NUMBER, NAME_OF_CAR, COLOR, YEAR, owner.address);

    const [nameOfCar, color, year] = await storeCarData.getCarDetails(
      CAR_NUMBER
    );
    const carOwner = await storeCarData.getCarOwner(CAR_NUMBER);

    expect(nameOfCar).to.equal(NAME_OF_CAR);
    expect(color).to.equal(COLOR);
    expect(year).to.equal(YEAR);
    expect(carOwner).to.equal(owner.address);
  });

  it("should allow owner to transfer ownership", async function () {
    await storeCarData
      .connect(owner)
      .storeCarDetails(CAR_NUMBER, NAME_OF_CAR, COLOR, YEAR, owner.address);

    await storeCarData.connect(owner).transferOwnership(addr1.address);

    const carOwner1 = await storeCarData.getCarOwner(CAR_NUMBER);
    expect(carOwner1).to.equal(addr1.address);

    await storeCarData.connect(addr1).transferOwnership(addr2.address);

    const carOwner2 = await storeCarData.getCarOwner(CAR_NUMBER);
    expect(carOwner2).to.equal(addr2.address);
  });
});
