# CHALLENGE : PREDICT THE FUTURE BLOCK HASH

The lottery consists in guessing a full 256-bit hash. As such, it is a purely academic lottery: there are 2^256 possibilities,
making the winning probability effectively zero (I wrote about how big 2^256 is in a 
[previous challenge](https://github.com/econdepe/capturetheether/blob/master/Lotteries/GuessTheSecretNumber.md)). Nonetheless
it will teach us something interesting about the function `block.blockhash`.

## Strategy

This lottery appears to be uncrackable. Its design is in principle flawless. A future block hash is completely unpredictable,
and we have to lock in our guess before it is produced. The implementation of this procedure is sound, so the only possible
loophole must be a wrong assumption about how the Solidity functions used in the contract work. Indeed, we can find in the 
[documentation](https://solidity.readthedocs.io/en/v0.4.21/units-and-global-variables.html) the following remark:

> * `block.blockhash(uint blockNumber) returns (bytes32)`: hash of the given block - only works for 256 most recent blocks
> excluding current

That's our loophole! `block.blockhash` becomes predictable after 256 blocks. Although the documentation doesn't say it
explicitly, what the function returns after 256 blocks is simply the `bytes32` 0***. Therefore we can enter that guess, wait
256 blocks, and then call `settle`. Although this can be easily done by hand, not to commit mistakes when counting the blocks
passed, we can also write an auxiliary smart contract that will make sure that `settle` is called only when the condition of
256 blocks passed is true. As in the previous challenge, this auxiliary smart contract must also be the one entering the
guess.

## Steps to follow

1. Write a smart contract that enters the guess 0 by calling `lockInGuess`. It must register the block where this call is
produced.
2. We can include a "counter" function in this smart contract such that it returns the number of blocks that have passed
since the lock-in block. Only when this counter returns a number bigger than 256 should we call another function that would
in turn call `settle()` of the capturetheether contract.
3. However, the safest way to proceed is that this function, call it `win()`, in charge of calling `settle()` have a
`require` statement, enforcing the condition on the number of blocks passed. In this way, `settle()` will only be called when
the requirement is fulfilled.
An example of a smart contract with these features is **./PredictTheBlockHash.sol**.

## Lesson learnt

This example has taught us an important lesson about the function `block.blockhash`, namely that it only retains the hashes of
the last 256 blocks. Actually this feature could have been used in the previous challenges as they were invoking this function
too; although the solutions presented were faster.

This is the last of the lotteries, and by now we should be quite convinced of the dangers of using timestamps and block hashes
for generation of random numbers. Do not say that the [official documentation](
https://solidity.readthedocs.io/en/v0.4.21/units-and-global-variables.html) hadn't warned you already!

> Do not rely on `block.timestamp`, `now` and `block.blockhash` as a source of randomness, unless you know what you are doing.



### *** Note on zero hash

When we say that the hash is zero, we mean it is the `bytes32` `0x00000000000000000000000000000000`. Notice that is different
than the hash of 0, or a null input. Those are not zero! You can check who they are with your favorite hash function.
