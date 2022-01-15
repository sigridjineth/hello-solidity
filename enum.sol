pragma solidity >=0.7.0 < 0.9.0;

contract lec38 {
    enum CarStatus {
        TurnOff,
        TurnOn,
        Driving,
        Stop
    }

    CarStatus public carStatus;

    constructor() payable {
        carStatus = CarStatus.TurnOff;
    }

    event carCurrentStatus(CarStatus _carStatus, uint256 _carStatusInInt);

    function turnOnCar() public {
        require(carStatus == CarStatus(0), "To turn on, your car must be turned off");
        carStatus = CarStatus(1);
        emit carCurrentStatus(carStatus.uint256(carStatus));
    }

    function DrivingCar() public {
        require(carStatus == CarStatus.TurnOn, "To drive a car, your car must be turned on");
        carStatus = CarStatus.Driving;
        emit carCurrentStatus(carStatus.uint256(carStatus));
    }

    function StopCar() public {
        require(carStatus == CarStatus.Driving, "To drive a car, your car must be turned on");
        carStatus = CarStatus.Stop;
        emit carCurrentStatus(carStatus,uint256(carStatus));
    }

    function turnOffCar() public {
        require(carStatus == CarStatus.TurnOn 
                || carStatus == CarStatus.Stop , "To turn off, your car must be turned on or driving");
        carStatus = CarStatus.TurnOff;
        emit carCurrentStatus(carStatus,uint256(carStatus));
    }

    function CheckStatus() public view returns(CarStatus) {
        return carStatus;
    }
}
