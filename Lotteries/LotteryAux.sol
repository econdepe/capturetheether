pragma solidity ^0.4.21;

contract LotteryAux {
    address owner;
    
    // define owner
    constructor() public {
        owner = msg.sender;
    }
    
    // fallback function. Makes the contract able to receive ether
    function () public payable {}
    
    // allow withdrawal of contract funds (only to the owner)
    function withdraw() public {
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }
}
