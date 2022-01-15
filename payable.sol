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
        (bool sent, ) = _to.call {
            value: msg.value
            // gas: 1000
        }("");
        require(sent, "Failed to send Ether");
        emit howMuch(msg.value);
    }
}
