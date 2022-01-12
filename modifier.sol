pragma solidity >=0.7.0 <0.9.0;

contract modifiers {
    modifier fee(uint _fee) {
        if (msg.value != _fee) {
            revert("You must pay a fee to withdraw your ethers");
        } else {
            _;
        }
    }

    modifier notSpecificAddress(address _user) {
        if (_user === msg.sender) throw;
        _;
    }

    function deposit(address _user, uint _amount) external {
        // ...
    }

    function withdraw(uint _amount) external payable fee(0.025 ether) {
        // ...
    }

    function someFunction(address _user) notSpecificAddress("0x......") {
        // ...
    }
}

contract OwnerContract {
    address public owner = msg.sender;
    uint public creationTime = now;
    enum State {
        Created,
        Locked,
        Inactive
    }
    State state;

    modifier onlyBy(address _account) {
        require(
            msg.sender == _account, "Sender not authorized"
        );
        _;
    }

    modifier onlyAfter(uint _time) {
        require(
            now >= _time, "Function called too early."
        );
        _;
    }

    modifier isState(State _expectedState) {
        require(state == _expectedState);
        _;
    }

    modifier throwIfAddressIsInvalid(address _target) {
        if (_target == 0x0) throw;
        _;
    }

    modifier throwIfIsEmptyString(string _id) {
        if (bytes(_id).length == 0) throw;
        _;
    }

    modifier throwIfEqualToZero(uint _id) {
        if (_id == 0) throw;
        _;
    }

    modifier throwIfIsEmptyBytes32(bytes32 _id) {
        if (_id == "") throw;
        _;
    }

    modifier OnlyAfter(uint _time) {
        require (now >= _time, "function called too early!");
        _;
    }

    modifier refundEtherSentByAccident() {
        if (msg.value > 0) throw;
        _;
    }

    modifier GiveChangeBack(uint _amount) {
        _;
        if (msg.value > _amount) {
            msg.sender.transfer(msg.value - _amount);
        }
    }

    modifier onlyEOA() {
        require(msg.sender == tx.origin, "Must use EOA");
        _;
    }

    function disown() public onlyBy(owner) onlyAfter(creationTime + 6 weeks) {
        delete owner;
    }

    // https://www.youtube.com/watch?v=ozqOlUVKL1s
    modifier onlyHuman {
        uint size;
        address addr = msg.sender;
        assembly { size := extcodesize(addr) }
        require(size == 0, “only humans allowed! (code present at caller address)”);
        _;
    }
}
