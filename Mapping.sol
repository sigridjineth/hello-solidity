pragma solidity ^0.6.0;

contract Mapping {
    // Mappings
    mapping(uint => string) public names;
    mapping(uint => Book) public books;
    mapping(address => mapping(uint => Book)) public myBooks;

    struct Book {
        string title;
        string Author;
    }

    constructor() public {
        names[1] = "Kim";
        names[2] = "Park";
        names[3] = "Lee";
    }

    mapping(string => uint) public nicknames;

    function set(string memory name, uint amount) public {
        nicknames[name] = amount;
    }

    function get(string memory name) public view returns (uint) {
        return nicknames[name];
    }

    function addBook(uint _id, string memory _title, string memory _author) public {
        books[_id] = Book(_title, _author);
    }

    function addMyBook(uint _id, string memory _title, string memory _author) public {
        myBooks[msg.sender][_id] = Book(_title, _author);
    }
}
