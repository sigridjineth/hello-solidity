pragma solidity >=0.7.0 < 0.9.0;

contract MobileBanking {

    address owner;

    constructor() payable {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only Owner!");
        _;
    }

    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

    function sendETH(address payable _to) public onlyOwner payable {
        require(msg.sender == owner, "Only Owner!");
        require(msg.sender.balance >= msg.value, "Your Balance is not Enough");
        _to.transfer(msg.value);
        emit SendInfo(msg.sender, (msg.sender).balance);
    }

    function checkValueNow() public onlyOwner {
        emit MyCurrentValue(msg.sender, (msg.sender).balance);
    }

    function checkUserMoney(address _to) public onlyOwner {
        emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
    }
}
