pragma solidity >=0.7.0 <0.9.0;


contract lec24{
    string[] private countryList = ["South Korea","North Korea","USA","China","Japan"];
    
    function linearSearch(string memory _search) public view returns(uint256, string memory){
        
        for(uint256 i=0; i<countryList.length; i++){
            if(keccak256(bytes(countryList[i])) == keccak256(bytes(_search))){
                return (i, countryList[i]);
            }
        }
        
        return(99,"Nothing");
        
    }

}
