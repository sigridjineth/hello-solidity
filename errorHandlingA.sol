pragma solidity >=0.7.0 <0.9.0;

contract lec25 {
    // Gas is spect; gas를 환불하지 않는다. ~0.7
    // 0.8 이후에는 오직 내부적 에러 테스트 용도, 불변성 체크 용도로 사용 하라고 나와 있다.
    // 웬만하면 assert는 크게 일어나지 않는다.
    function assertNow() public pure {
        assert(false);
    }
    // Gas is not spent
    function revertNow() public pure {
        revert("revert");
    }
    // require = revert + if
    function requireNow() public pure {
        require(false, "occured");
    }
    function onlyAdults(uint256 _age) public pure returns(string memory) {
        if (_age < 19) {
            revert("You are now allowed to pay for the cigarette");
        }
        return "Your payment is succeeded";
    }
    function onlyAdults2(uint256 _age) public pure returns(string memory) {
        require(_age > 19, "You are not allowed to pay for the cigarette");
        return "Your payment is succeeded";
    }
}
