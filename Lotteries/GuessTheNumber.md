# CHALLENGE : GUESS THE NUMBER

The lottery consists in guessing an 8-bit unsigned (i.e. positive) integer.

## Strategy

This is not much of a challenge. The number that wins the lottery is written directly in the smart contract, and obviously it
is [42](https://en.wikipedia.org/wiki/The_Hitchhiker%27s_Guide_to_the_Galaxy_(novel)) :smirk:.

## Steps to follow

1. Deploy the contract *GuessTheNumberChallenge* by clicking "Begin Challenge". This will move 1 ether from our address to the
contract address just created.
2. Load the deployed contract in Remix, and run the function `guess` with input `42`. We must set `value = 1 ether` in the
"Run" tab of Remix, as this amount will be charged, and transferred to the contract, for running the function. Because we 
guessed the number correctly, 2 ether will be transferred immediately to our account.
3. We can run the function `isComplete` in Remix to make sure it returns `true`. This costs no gas, as the function is of type `view` (i.e.: no need of writing into the blockchain, we simply read its state). Click on "Check solution" to get the points.

## Lesson learnt

Quoting https://solidity.readthedocs.io/en/v0.4.21/contracts.html:

> Everything that is inside a contract is visible to all external observers. Making something private only prevents other contracts from accessing and modifying the information, but it will still be visible to the whole world outside of the blockchain.

Even if we had no access to the source code of the contract and the variable `answer` had been made private, we will always have access to the compiled code of the contract, from where we can extract the values of pre-assigned variables. The lesson here is that you should always program your smart contracts so that they are secure even if someone has access to their source code.
