pragma solidity >=0.7.0 < 0.9.0;

library SafeMath0{
    //0~255;
    function add(uint8 a, uint8 b) internal pure returns (uint8) {
        require(a+b >= a , "SafeMath: addition overflow");
        return a + b;
    }
}

contract HiSolidity{
    event Hi(string _str);
    
    function hi() public {
        emit Hi("Hello solidity");
    }
}
