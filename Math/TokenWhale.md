# CHALLENGE : TOKEN WHALE

This time we are handed a smart contract that "mimics" somewhat that of an ERC20 token. A token called SET is created upon
deployment of the smart contract, allocating all the minted tokens, which happen to be 1000, to our address. The smart contract allows to trade tokens in two ways: directly from one address to another, or indirectly as one address spends the tokens from another address to a third. The second address must have previously allowed for the first address to use the tokens in this way.
Our goal is to create and accumulate new tokens, so that we end up with more than 1000000.

## Strategy

You can notice that some care has been taken in this contract to try to avoid the integer overflows loopholes that we exploited in the previous contract. However this has not been done properly. We do not need much sofistication to solve this challenge, as we can detect a flawed design in the smart contract simply by reading it with care.

The transfer functions would be ok if used always in combination, but something smells fishy in the `transferFrom` function.
The requirements make sense, as well as the instruction to reduce the allowance. The problem is in the call of
`_transfer`, as this function spends the tokens from the address `msg.sender`, and not from the `from` address as it should!
Moreover, the tokens are transferred using the `_transfer` function, which makes no check that the spender does have the
funds!

Therefore, a possible strategy to solve this challenge is to allow another auxiliary address that we control to spend, say,
10^7 tokens. If from this other address we call `transferFrom(our original address, our original address, qty)`, where by
construction `qty <= balanceOf[our address]`, our balance will increase by `qty` tokens, and the TokenWhaleChallenge (not so)
smart contract will "remove" the tokens from this other address incurring in integer overflow (since our auxiliary
address has no tokens, but the contract does not care!). Repeating this step we can acquire as many tokens as desired.

## Steps to follow

1. After deploying the smart contract, we call the function `approve(our auxiliary address, 10^7)`. If you only have one
address, you can easily create a new one in Metamask. Notice that Metamask warns you that you are authorizing the expense of
SET tokens, quite cool!
2. Now change to your auxiliary address, and from there call
`transferFrom(our original address, our auxiliary address, 1000)`. After this step our balance is 2000 tokens.
3. Repeat step 2 nine times, each of them using all the tokens in our address (unless you want to spend more time with
these brainless operations).
4. Our balance should be 1024000 SET tokens by now, and we can happily call `isComplete()`.

## Lesson learnt

I don't see much to be learnt here other than putting care in designing a proper logic for your smart contract. At the end
of the day we exploited integer overflow as in the previous challenge. We could do that because integer overflow was
accounted for only in some of the functions of the smart contract. So probably a good advice is to take care of it for all
the places in your smart contract where it could show up.
