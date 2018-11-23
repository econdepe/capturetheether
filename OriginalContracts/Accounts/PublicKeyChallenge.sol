/*
Recall that an address is the last 20 bytes of the keccak-256 hash of the address’s public key.

To complete this challenge, find the public key for the owner’s account.
*/

pragma solidity ^0.4.21;

contract PublicKeyChallenge {
    address owner = 0x92b28647ae1f3264661f72fb2eb9625a89d88a31;
    bool public isComplete;

    function authenticate(bytes publicKey) public {
        require(address(keccak256(publicKey)) == owner);

        isComplete = true;
    }
}
