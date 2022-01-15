pragma solidity >=0.5.0 < 0.9.0;

// 스마트 컨트랙트가 이더를 받을 수 있게 한다.
// 이더를 받은 후에 어떠한 행동을 취하게 할 수 있다.
// call 함수로 없는 함수가 불려질 때, 어떠한 행동을 취하게 할 수 있다.

// receive는 순수하게 이더만 받을 때 작동합니다.
// fallback은 함수를 실행하면서 동시에 이더를 보낼 때, 불려진 함수가 없을 때 작동합니다.

contract Bank {
    event JustFallback(address _from, string message);
    event ReceiveFallback(address _from, uint256 _value, string message);
    event JustFallbackWithFunds(address _from, uint256 _value, string message);
    fallback() external payable {
        emit JustFallback(msg.sender, "JustFallback is called");
        emit JustFallbackWithFunds(msg.sender, msg.value, "JustFallbackWithFUnds is called");
    }
    receive() external payable {
        emit ReceiveFallback(msg.sender, msg.value, "ReceiveFallback is called");
    }
}

contract You {
    // receive()
    // You의 msg.sender는 자신을 실행한 transaction account를 의미한다.
    // call을 제외하고 나머지는 정적인 가스 비용이 되기 때문에 2300 가스를 사용해서 이벤트를 출력하기 힘들다는 뜻이다.
    // 그래서 send나 transfer로 함수를 실행하기 위해서는 이벤트에 메시지를 삭제해서 가스 비용을 2300 이하로 떨어뜨리는 방법을 고민해볼 수 있다.
    // 어, 그런데 0.7 버전에서는 또 transfer, gas는 된다. 0.8 버전 이상에서는 가스 비용이 올라간 것이라고 유추해볼 수 있다.
    function DepositWithSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed");
    }

    function DepositWithTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function DepositWithCall(address payable _to) public payable {
        // 0.7 ~
        (bool sent, bytes memory data) = _to.call {
           value: msg.value
        }("");
    }

    // fallback()
    // no pat ether, no payable stated
    function JustGiveMessage(address _to) public {
        (bool success, ) = _to.call("Hi");
        require(success, "Failed");
    }

    function JustGiveMessageWithFunds(address payable _to) public payable {
        (bool success, ) = _to.call{
            value: msg.value
        }("Hi");
        require(success, "Failed");
    }
}
