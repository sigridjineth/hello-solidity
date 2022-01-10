pragma solidity >= 0.7.0 < 0.9.0;

contract struct {
    struct Character {
        uint256 age;
        string name;
        string job;
    }

    // Mapping
    mapping(uint256 => Character) public CharacterMapping;
    // Array
    Character[] public CharacterArray;

    function createCharacter(uint256 _age, string memory _name, string memory _job) pure public returns(Character memory) {
        return Character(_age, _name, _job);
    }

    function createCharacterMapping(uint256 _key, uint256 _age, string memory _name, string memory _job) public {
        CharacterMapping[_key] = Chracter(_age, _name, _job);
    }

    function getCharacterMapping(uint256 _key) public view returns(Character memory) {
        return CharacterMapping[_key];
    }

    function createCharacterArray(uint256 _age, string memory _name, string memory _job) public {
        CharacterArray.push(Character(_age, _name, _job));
    }

    function getCharacterArray(uint256 _index) public view returns(Character memory) {
        return CharacterMapping[_index];
    }
}
