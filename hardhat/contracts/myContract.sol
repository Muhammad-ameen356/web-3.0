// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract StoreCarData {
    struct CarDetailType {
        address owner;
        string nameOfCar;
        string color;
        uint256 year;
    }

    mapping(string => CarDetailType) carDetailMap;
    CarDetailType public carDetail;

    // Constructor function execute only when the conntract initializes
    constructor() {
        carDetail.owner = msg.sender;
    }

    function storeCarDetails(
        string memory carNumber,
        string memory nameOfCar,
        string memory color,
        uint256 year,
        address owner
    ) public {
        CarDetailType storage car = carDetailMap[carNumber];
        car.color = color;
        car.nameOfCar = nameOfCar;
        car.year = year;
        car.owner = owner;
    }

    function getCarDetails(
        string memory carNumber
    )
        public
        view
        returns (string memory nameOfCar, string memory color, uint256 year)
    {
        CarDetailType storage car = carDetailMap[carNumber];
        return (car.nameOfCar, car.color, car.year);
    }

    function getCarOwner(
        string memory carNumber
    ) public view returns (address owner) {
        CarDetailType storage car = carDetailMap[carNumber];
        return car.owner;
    }

    modifier onlyOwner() {
        require(msg.sender == carDetail.owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        carDetail.owner = newOwner;
    }
}
