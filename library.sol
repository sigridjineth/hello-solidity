pragma solidity >=0.7.0 < 0.9.0;

// o.8 -> overflow revert
// overflow: 0~255 -> 256 -> 0

library SafeMath {
    function add(uint8 a, uint8 b) internal pure returns(uint8) {
        // a: 1, b: 255 -> a + b = 256 -> 0 >= 1 overflow
        require(a + b >= a, "SafeMath: addition overflow");
        return a + b;
    }
}

contract lec40 {
    // uint8에 해당하는 데이터 타입에는 SafeMath 라는 데이터 타입을 사용해라.
    using SafeMath for uint8;
    uint8 public a;

    function becomeOverflow(uint8 _num1, uint8 _num2) public {
        a = SafeMath.add(_num1, _num2);
    }
}
