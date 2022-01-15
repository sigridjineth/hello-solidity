pragma solidity >=0.5.0 < 0.9.0;

// 스마트 컨트랙트가 이더를 받을 수 있게 한다.
// 이더를 받은 후에 어떠한 행동을 취하게 할 수 있다.
// call 함수로 없는 함수가 불려질 때, 어떠한 행동을 취하게 할 수 있다.

// receive는 순수하게 이더만 받을 때 작동합니다.
// callback은 함수를 실행하면서 이더를 보낼 때, 불려진 함수가 없을 때 작동합니다.

contract Bank {
    // 0.6 이전의 fallback
    event JustFallbackWithFunds(address _from, uint256 _value, string message);
    function() external payable {
        // msg.sender는 스마트 컨트랙트를 실행시키는 주체를 지칭한다.
        emit JustFallbackWithFunds(msg.sender, msg.value, "JustFallbackWithFunds is called");
    }
}

contract You {
    // receive()
    // You의 msg.sender는 자신을 실행한 transaction account를 의미한다.
    function DepositWithSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed");
    }

    function DepositWithTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function DepositWithCall(address payable _to) public payable {
        // ~ 0.7
        (bool sent, ) = _to.call.value(msg.value)("Hi");
        require(sent, "Failed to send Ether");

        // 0.7 ~
        // (bool sent, string memory data) = _to.call {
        //    value: msg.value
        // }("");
    }

    // fallback()
    // no pat ether, no payable stated
    function JustGiveMessage(address _to) public {
        // ~ 0.7
        // call function "Hi", but no Hi Function, thus would be callbacked.
        (bool sent, ) = _to.call("Hi");
        require(sent, "Failed to send Ether");
        // 0.7 ~
        // (bool success, ) = _to.call("Hi");
        // require(success, "Failed");
    }
}
