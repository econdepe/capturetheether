# CHALLENGE : GUESS THE RANDOM NUMBER

The lottery consists in guessing an 8-bit unsigned (i.e. positive) integer. Things start to get a bit more interesting as the lottery-winning number seems to be generated randomly in this challenge,
making it impossible to guess correctly in our first try.

## Strategy

The critical question is: how random is this generation? Well, not much... The random number is generated by feeding
`keccak256` two inputs***, then converting the hash produced (of type `bytes32`) to `int8`. This last step simply computes
the hash modulo 2^8. Because we know the generating process from the seeds, the lottery-winning number is only as random
as the inputs fed to `keccak256`.

These two inputs are `block.blockhash(block.number - 1)` and `now`. The first one is the hash of the block previous to the one
where the contract *GuessTheRandomNumberChallenge* is deployed, while the second one is the timestamp of the latter contract
creation. Unfortunately for the lottery creator, these inputs are not random after the contract has been deployed. They can be
looked up directly in a blockchain explorer (for instance https://ropsten.etherscan.io).

## Steps to follow

1. We click "Begin Challenge" to deploy the contract. We are given the contract address. Entering this address in etherscan,
we can see the creation transaction (*txn*) in the section "Misc", to which we can access straightforwardly by following the
link.
2. Among the items in "Transaction Information", we can find *Block Height*. That number is what `block.number` returns (it is
a good exercise to check this with a test smart contract).
3. Another item  we see is *TimeStamp*, which is the time at which the block was mined. It comes in format yyyy/mm/dd
hh:min:sec, and when translated to [UNIX time](https://en.wikipedia.org/wiki/Unix_time), it equals the variable `now`.
4. Once we have the values of `block.number` and `now`, with our favorite Solidity compiler (remember you can simply use
Remix in the Javascript VM environment) we compute the hash using `keccak256` as in the contract GuessTheRandomChallenge, and
convert it to `uint8`. The resulting integer is the winning number.

## Lesson learnt

In order to generate a truly random number, the seed must be random as well. In this challenge, the seed is publicly
available, as is the generation algorithm from the seed. Therefore there's no mystery in winning this lottery.


### *** Note on hashing several arguments

When feeding several arguments to `keccak256`, the hash that is computed is that of the concatenation of all the arguments'
binary representations.