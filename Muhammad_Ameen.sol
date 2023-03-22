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
        uint256 year
    ) public {
        CarDetailType storage car = carDetailMap[carNumber];
        car.color = color;
        car.nameOfCar = nameOfCar;
        car.year = year;
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
    ) public view returns (string memory owner) {
        CarDetailType storage car = carDetailMap[carNumber];
        return (car.owner);
    }

    modifier onlyOwner() {
        require(msg.sender == carDetail.owner);
        _;
    }

    function transferOwnership(address newOwner) public {
        carDetail.owner = newOwner;
    }
}
