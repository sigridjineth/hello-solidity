pragma solidity >=0.7.0 < 0.8.0;

import "./lec41_1.sol";

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/math/SafeMath.sol";

contract lec41 is HiSolidity{
    using SafeMath0 for uint8;
    uint8 public a; 
    uint256 public maximum = 2 ** 256 -1;
    function becomeOverflow(uint256 _num1,uint256 _num2) public {
        a = _num1.add(_num2);
       
    } 
    
}
