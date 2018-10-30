# CHALLENGE : GUESS THE NEW NUMBER

The lottery consists in guessing an 8-bit unsigned (i.e. positive) integer. The random lucky number is generated exactly as in
the previous challenge (Guess the random number). But now the number is
generated at the same time as the guess is made, so we don't have a priori information on who `block.number` or `now` are going
to be.

## Strategy

This challenge is solved by having an auxiliary smart contract call the lottery one, so that the execution of the call happens
together with the generation of our guess - i.e.: they go on the same block. In such a case, the variables `block.number` and
`now` will be shared. Therefore the auxiliary smart contract just needs to call the `guess` function from the contract
GuessTheNewNumber with input `uint8(keccak256(block.blockhash(block.number - 1), now))`.

The auxiliary smart contract needs to be able to receive ether. To make it possible, it's neccesary to include a fallback
payable function (see "Fallback Function" in https://solidity.readthedocs.io/en/v0.4.21/contracts.html). Also, if we want to
retrieve the money in this contract, we must include a withdraw function.

The properties above will be used in the next challenges too, so we can implement a contract class LotteryAux, and then make
the auxiliary smart contract inherit these properties. I have included in this directory both the class "LotteryAux.sol" and
the auxiliary contract "GuessTheNewNumberAux.sol" for clarity. Notice also that calling a payable function requires a
particular syntax.

## Steps to follow

1. We deploy the contract *GuessTheNewNumber* by clicking "Begin Challenge", and take note of its address.
2. We deploy the contract *GuessTheNewNumberAux*, and call the function `guessNow` with the aforementioned address as input.
This function implements the strategy we discussed above, calling the `guess` function of the *GuessTheNewNumber* contract with
the lucky input.
3. If we did things properly, we should see that the balance of the contract *GuessTheNewNumberAux* is `2 ether`
now (that we can withdraw back to our account calling its `withdraw` function). Instead the balance of *GuessTheNewNumber* is
`0 ether`, and its `isComplete` function returns `true`.

## Lesson learnt

This lottery would be secure if we could only interact with it by calling its functions "by hand". But it is critical to
realize that we can automatize interaction with smart contracts through other smart contracts. A smart contract doesn't
distinguish who's calling its functions, whether it is a personal account or another smart contract. Both of them are simply
addresses in the Ethereum blockchain.
