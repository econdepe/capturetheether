/*
To complete this challenge, all you need to do is call a function.

The “Begin Challenge” button will deploy the following contract:
*/

pragma solidity ^0.4.21;

contract CallMeChallenge {
    bool public isComplete = false;

    function callme() public {
        isComplete = true;
    }
}
