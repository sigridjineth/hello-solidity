pragma solidity >=0.7.0 <0.9.0;

contract math {
    function division(uint256 _num1, uint256 _num2) public pure returns (uint256) {
        require(_num1 < 10, "num1 should not be more than 10");
        return (_num1 / _num2);
    }
}

contract runner {
    // Catch Error(string memory reason){ … } : revert나 require를 통해 생성된 에러 용도
    event catchErr(string _name, string _err);
    // Catch panic(uint errorcode) { … } : assert를 통해 생성된 에러
    event catchPanic(string _name, uint256 _err);
    // Catch(bytesmemoryLowlevelData) { … } : low level error를 잡는다
    event catchLowLevelErr(string _name, bytes _err);

    // 다른 스마트 컨트랙을 인스턴스화 해서, try/catch문이 있는 스마트 컨트랙의 함수를 불러와서 사용
    math public mathInstance = new math();

    function playTryCatch(uint256 _num1, uint256 _num2) public returns(uint256, bool) {
        try mathInstance.division(_num1, _num2) returns(uint256 value) {
            return (value, true);
        } catch Error(string memory _err) {
            emit catchErr("revert/require", _err);
            return (0, false);
        } catch Panic(uint256 _errorCode) {
            emit catchPanic("assertError/Panic", _errorCode);
            return (0, false);
        } catch (bytes memory _errorCode) {
            emit catchLowLevelErr("Low Level Error", _errorCode);
            return (0, false);
        }
    }
}
