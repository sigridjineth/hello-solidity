pragma solidity >= 0.7.0 < 0.9.0;

contract Snoop {
    
    string public familyName = "snoop";
    string public givenName = "so";
    uint256 public money = 100; 
    
    constructor(string memory _givenName) public {
        givenName = _givenName;
    }
    
    
    function getFamilyName() view public  returns(string memory){
        return familyName;
    } 
    
    function getGivenName() view public  returns(string memory){
        return givenName;
    } 
    
    // 먼저 오버라이딩을 하기 위해서는, 오버라이딩할 함수에 virtual 을 명시해주어야합니다.
    function getMoney() view  public virtual returns(uint256){
        return money;
    }
    
    
}

contract Jin is Snoop("Jin"){
    
    
    uint256 public earning = 0;
    function work() public {
        earning += 100;
    }
    
     function getMoney() view  public override returns(uint256){
        return money+earning;
    }
}
