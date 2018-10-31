# CHALLENGE : GUESS THE SECRET NUMBER

The lottery consists in guessing an 8-bit unsigned (i.e. positive) integer. This challenge is very similar to the previous
one (Guess The Number), only that now what's stored on-chain is the hash of the number, rather than the number itself.

## Strategy

At the moment there is no known way of reversing the keccak256 hash function***. What this means is that no
attack algorithm will perform much better than sheer brute-force. Brute force is an essentially useless attack since the number
of different hashes is a humongous number, 2^256. It's hard to visualize how big this number is, but let's try:

If we had a chip that would fit
inside a hydrogen atom (smallest atom in the universe), which would take the smallest ever-measured lapse of time (10^(-16) s)
to compute a hash, and we filled the whole surface of the earth with an ultra-compact 1-cm-tall layer of these chips, it would
take the whole age of the universe to compute 2^256 hashes... :dizzy_face:

Luckily for us and our electricity bill, the trick here is that we know that the lucky number must be a `uint8`, and there are only
2^8 = 256 of those. Hashing all of them, and checking which one gives the hash we see in the contract, is a matter of seconds.
This check can be performed in a Solidity compiler running on a PC, but we can use Remix too. In this way
we stick to our minimum set of tools.

## Steps to follow

1. Write a smart contract that unhashes by brute force `answerHash`. That can be done with a simple `for` loop. I have written
one example in **./Unhash.sol**. Running that smart contract on the Remix Javascript VM will tell us that the lucky number is 170.
2. Once the answer is known, you can proceed as with the previous challenge.

## Lesson learnt

This way of programming a lottery is quite useless. Even if we assume that we trust a secure generation of the lucky number
(which is not obvious from the contract), hashing the answer solves nothing. If the hash is secure (difficult to unhash), that
means there must be a huge number of possible inputs, which makes as unlikely its unhashing as its guessing by some participant.
And giving participants a fair chance of winning means having roughly the same number of possible inputs as participants, which
in turn makes a brute-force attack feasible.


### *** Note on hash functions

`keccak256` is the SHA-3 function implemented in Ethereum. SHA-3 (Secure Hash Algorithm 3) is a set of standards for
cryptographic hash functions defined in 2015 by the U.S. National Institute of Standards and Technology (NIST). Because
the implementation of `keccak256` happened a little bit before the publication of the NIST standards, `keccak256` is
different than the function SHA3-256 that we can find online, but of course equally secure.
