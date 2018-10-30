pragma solidity ^0.4.21;

contract LotteryAux {
    address owner;

    constructor() public {
        owner = msg.sender;
    }
    
    function () public payable {}
    
    function withdraw() public {
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }
}
