pragma solidity >=0.7.0 <0.9.0;

contract character {
    string private name;
    uint256 private power;
    constructor(string memory _name, uint256 _power) {
        name = _name;
        power = _power;
    }
}

// 외부 스마트 컨트랙트를 생성할 때 try, catch
contract runner {
    event catchOnly(string _name, string _err);
    function playTryCatch(string memory _name, uint256 _power) public returns (bool successOrFail) {
        try new character(_name, _power) {
            return (true);
        } catch {
            emit catchOnly("catch", "ErrorS!!");
            return (false);
        }
    }
}

// 내부 스마트 컨트랙에서 함수를 부를때 try/catch
contract runner2 {
    function simple() public returns (uint256) {
        return 4;
    }
    event catchOnly(string _name, string _err);
    function playTryCatch() public returns (uint256, bool) {
        // this 는 지금 현재 스마트컨트랙을 나타내고 있습니다.
        try this.simple() returns (uint256 _value) {
            return (_value, true);
        } catch {
            emit catchOnly("catch", "ErrorS!!");
            return (0, false);
        }
    }
}
