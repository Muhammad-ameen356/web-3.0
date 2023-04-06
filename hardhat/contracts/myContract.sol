// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract StoreCarData {
    struct CarDetailType {
        address owner;
        string nameOfCar;
        string color;
        uint256 year;
    }

    mapping(string => CarDetailType) private carDetailMap;

    //  ! Store Car Detials
    function storeCarDetails(
        string memory carNumber,
        string memory nameOfCar,
        string memory color,
        uint256 year
    ) public {
        require(bytes(carNumber).length > 0, "Car number cannot be empty");
        require(bytes(nameOfCar).length > 0, "Name of car cannot be empty");
        require(bytes(color).length > 0, "Color cannot be empty");
        require(year > 0, "Year must be greater than zero");

        CarDetailType storage car = carDetailMap[carNumber];
        require(car.owner == address(0), "Car already exists");

        car.owner = msg.sender;
        car.color = color;
        car.nameOfCar = nameOfCar;
        car.year = year;
    }

    // ! Get Car Details
    function getCarDetails(
        string memory carNumber
    )
        public
        view
        returns (string memory nameOfCar, string memory color, uint256 year)
    {
        CarDetailType storage car = carDetailMap[carNumber];
        require(car.owner != address(0), "Car does not exist");

        return (car.nameOfCar, car.color, car.year);
    }

    // ! Get the owner of the car
    function getCarOwner(
        string memory carNumber
    ) public view returns (address owner) {
        CarDetailType storage car = carDetailMap[carNumber];
        require(car.owner != address(0), "Car does not exist");

        return car.owner;
    }

    modifier onlyOwner(string memory carNumber) {
        require(
            msg.sender == carDetailMap[carNumber].owner,
            "Only the owner can perform this action"
        );
        _;
    }

    // ! Transfer ownership of the car
    function transferOwnership(
        string memory carNumber,
        address newOwner
    ) public onlyOwner(carNumber) {
        carDetailMap[carNumber].owner = newOwner;
    }
}
