pragma solidity ^0.7.0;

contract add {
    uint256 public num = 0;
    event Info(address _addr, uint256 _num);

    function plusOne() public {
        num = num + 1;
        emit Info(msg.sender, num);
    }
}

contract caller {
    uint256 public num = 0;
    function callNow(address _contractAddr) public payable {
        (bool success, ) = _contractAddr.call(
            abi.encodeWithSignature("plusOne()")
        );
        require(success, "Failed to transfer ETH");
    }
    function delegateCallNow(address _contractAddr) public payable {
        (bool success, ) = _contractAddr.delegatecall(
            abi.encodeWithSignature("plusOne()")
        );
        require(success, "Failed to transfer ETH");
    }
}
