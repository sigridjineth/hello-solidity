pragma solidity ^0.6.0;

contract HotelRoom {
    enum Status {
        Vacant,
        Occupied
    }
    Status currentStatus;
    address payable public owner;
    event Occupy(address _occupant, uint _value);
    constructor() public {
        owner = msg.sender;
        currentStatus = Status.Vacant;
    }
    modifier onlyWhileVacant {
        // check status
        require(currentStatus == Status.Vacant, "Currently occupied");
        _;
    }
    modifier costCheck(uint _amount) {
        // check price
        require(msg.value >= 2 ether, "Not Enough Provided");
        _;
    }
    receive() external payable onlyWhileVacant costCheck(2 ether) {
        currentStatus = Status.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}
