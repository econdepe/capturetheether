pragma solidity ^0.4.21;

contract Unhash {
    bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;
    
    function find() public view returns(uint8) {
        uint8 i;
        
        for (i = 0; i < 2 ** 8; i++) {
            if (keccak256(i) == answerHash) {
                return i;
            }
        }
    }
}
