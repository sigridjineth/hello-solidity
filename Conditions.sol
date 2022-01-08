pragma solidity ^0.6.0;

contract Conditions {
    address public owner;
    constructor() public {
        owner = msg.sender;
    }
    // Conditionals
    function isEvenNumber(uint _number) public view returns(bool) {
        // 5 / 2 == 2 R 1
        // 4 / 2 == 2
        if (_number % 2 == 0) {
            return true;
        }
        return false;
    }
    // Loop
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    function countEvenNumbers() public view returns(uint) {
        uint count = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (isEvenNumber(numbers[i])) {
                count += 1;
            }
        }
        return count;
    }

    function isOwner() public view returns(bool) {
        return (msg.sender == owner);
    }
}
