# CHALLENGE : PREDICT THE FUTURE

The lottery consists in guessing an integer from 0 to 9. The generation of the lottery-winning number is as in the two previous
challenges, barring the modulo % 10 operation. The added feature in this challenge is that the guess must be submitted
strictly before the lucky number is generated, so that we cannot use the strategy we employed in the "Guess the new number"
challenge.

## Strategy

This lottery looks quite safe as there is no way to know what lucky number will be generated at the time we lock in our guess.
However, with an auxiliary smart contract we can have access to what this lucky number will be in later blocks, without
having to play the lottery (i.e.: without calling the function `settle` which triggers the generation of the random number).

So all we need to do is have our auxiliary smart contract call `settle()` only when the random generation via 
`uint8(keccak256(block.blockhash(block.number - 1), now)) % 10` yields the same number as our locked-in guess. This auxiliary
smart contract will probably have to be run several times (the creators were nice enough to give us only 10 possible guesses,
with a 10% winning chance each), until we get lucky. The only thing that we spend by doing that is a little bit of gas,
nothing compared to the big prize (2 ether) we will get when winning!

From the implementation of the contract *PredictTheFutureChallenge*, notice that the address calling `settle` must be the same
as the address locking in the guess. Therefore our auxiliary smart contract must do both.

## Steps to follow

1. Write a smart contract that can perform the two tasks discussed above. That is, it must be able to call the `lockInGuess`
function, and have another function that calls `settle` only when that is a winning play. I wrote a possible implementation
in "./PredictTheFutureChallengeAux.sol", where I called the latter function `checkGuess`.
2. Deploy the auxiliary smart contract, lock in a guess, and then call `checkGuess` as many times as needed. I needed to
increase MetaMask suggested gast limit, as my auxiliary smart contract consumed more gas than usual on the occasions it had
to call `settle()`. I did not make an effort to make this contract as efficient as possible as that is not the point of the
game.

## Lesson learnt

With this example we may be finally convinced that generating a proper random number via
`uint8(keccak256(block.blockhash(block.number - 1), now))` is not a good choice for a lottery. An auxiliary smart contract will
always have access to the number generated like that. Even if we are forced to lock in our guess before having access to this
number, as is the case in this challenge, we can have another smart contract "waiting" to play the lottery for us only when we
would be victorious. It's true such a "wait" is not free, but the gas spent would be affordable for a reasonable prize and a
reasonable number of possible guesses (this number should be of the order of magnitude of the number of participants in order
for the lottery to be fair).
