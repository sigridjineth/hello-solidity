pragma solidity >=0.5.0 < 0.9.0;

contract lec32 {
    event howMuch(uint256 _value);

    // return true or false
    function sendNow(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        // 실패하면 이벤트로 안넘어감
        require(sent, "Failed to send ETH");
        emit howMuch(msg.value);
    }

    // throw error
    function transferNow(address payable _to) public payable {
        // transfer는 에러를 리턴하므로 require 필요 없음. 실패하면 바로 이벤트 안넘어감
        _to.transfer(msg.value);
        emit howMuch(msg.value);
    }

    // check-effect entrance pattern. gas value variable
    function callNow(address payable _to) public payable {
        // return true or false
        (bool sent, bytes memory data) = _to.call {
            value: msg.value
            // gas: 1000
        }("");
        require(sent, "Failed to send Ether");
        emit howMuch(msg.value);
    }

    // call: 1) 송금하기 2) 스마트 컨트랙트 외부 함수 부르기 3) 가변적인 gas 소비
    // gas 가격 상승 가능에 따라 call 사용을 권장한다.
    // 재진입 공격 가능성이 있어서, Checkes Effects Interactions Pattern 사용
}

contract add {
    event JustFallback(string _str);
    event JustReceive(string _str);
    
    function addNumber(uint256 _num1, uint256 _num2) public pure returns(uint256) {
        return _num1 + _num2;
    }

    fallback() external payable {
        emit JustFallback("JustFallback is called");
    }

    receive() external payable {
        emit JustReceive("JustReceive is called");
    }
}

contract caller {
    event calledFunction(bool _success, bytes _output);

    function transferETH(address payable _to) public payable {
        (bool success, bytes memory data) = _to.call{
            value: msg.value
        }("");
        require(success, "failed to transfer ETH");
    }

    // after 0.7 version
    function callMethod(address _contractAddr, uint256 _num1, uint256 _num2) public {
        (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call(
            abi.encodeWithSignature("minusNumber(uint256, uint256)", _num1, _num2)
        );
        require(success, "failed to transfer ETH");
        emit calledFunction(success, outputFromCalledFunction);
    }

    function callMethodNothing(address _contractAddr) public payable {
        (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call{
            value: msg.value
        }(
            abi.encodeWithSignature("Nothing()")
        );
        require(success, "failed to transfer ETH");
        emit calledFunction(success, outputFromCalledFunction);
    }
}
