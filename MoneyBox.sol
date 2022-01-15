pragma solidity >=0.7.0 < 0.9.0;

/*
1. 1 ETH만 내야한다
2. 중복해서 참여 불가 (단, 누군가 적립금을 받으면 초기화)
3. 관리자만 적립된 이더 볼 수 있다.
4. 3의 배수 번째 사람에게만 적립된 이더를 준다.
*/

contract MoneyBox {
    event WhoPaid(address indexed sender, uint256 payment);
    event ToEarn(address indexed receiver, uint256 payment, string message);
    address owner;
    // key(round)
    mapping (uint256 => mapping(address => bool)) paidMemberList;
    uint256 round = 1;

    /*
    1 round: A: true . B: true . C: true paidMemberList
    2 round: E, R, D paidMemberList
    3 round: A, R, B paidMemberList
    4 round: all false
    */

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        require(msg.value == 1 ether, "please input 1 ether");
        require(paidMemberList[round][msg.sender] == false, "Must be a new player in each game.");
        paidMemberList[round][msg.sender] = true;
        emit WhoPaid(msg.sender, msg.value);

        // if 3 ether is deposited, that guy is third guy.
        if (address(this).balance == 3 ether) {
            // make msg.sender to payable guy.
            // send all eths of treasury to the third guy.
            emit ToEarn(msg.sender, address(this).balance, "Congratulations!");
            (bool sent, bytes memory data) = payable(msg.sender).call{
                value: address(this).balance
            }("");
            require(sent, "Failed to pay");
            // update round number and initalized.
            round++;
        }
    }

    function checkRound() public view returns(uint256){
        return round;
    }

    function checkValue() public view returns(uint256) {
        require(owner == msg.sender, "Only owner can check the value");
        // address 함수에 넣어서 현재 컨트랙트를 주소값으로 바꾼다.
        return address(this).balance;
    }
}
