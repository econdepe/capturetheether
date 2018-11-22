# CHALLENGE : TOKEN SALE

We are given a smart contract which simulates a token factory, where we can buy, and to which we can sell. Each token costs 1
ether, and we can only trade it with the factory. The smart contract is initialized with 1 ether, and the challenge is to
reduce this initial balance.

## Strategy

A priori reducing the initial balance of the contract looks like an impossible task since the only operations allowed are the
purchase of tokens (which increase the initial balance) and their sale (which simply restore the initial balance). The trick
must be in the implementation of these operations.

Indeed, no attention at all has been paid to possible integer overflows. Imagine the maximum value an unsigned (i.e.:
positive) integer can attain is N. Who is N+1? Solidity interprets N+1=0, N+2=1, N+3=2, etc. This is very dangerous
as we pass from a very big number to a very small one by simply adding one.

For the particular smart contract under consideration, integer overflow can be exploited in the function `buy`. Buying a number
of tokens X, such that X > 2^256/10^18 only costs (X * 10^18 % 2^256) wei, which is less than X ether (notice X < 2^256 to
avoid integer overflow for the number of tokens, we just want integer overflow in the price to pay).

## Steps to follow

1. Deploy the smart contract by clicking "Begin Challenge". Its initial balance is 1 ether.
2. Buy [2^256/10^18] + 1 tokens ([·] stands for integer part). Because ([2^256/10^18] + 1) * 10^18 % 2^256 = 415992086870360064,
the price we need to pay for this operation is only `415992086870360064 wei = 0.415992086870360064 ether`, making the contract
balance equal to ~1.416 ether.
3. Now we are owners of a zillion ([2^256/10^18] + 1 to be precise ;) ) tokens. If we sell simply one, we'll get 1 ether back
from the contract, leaving its balance equal to ~0.416 ether. Calling `isComplete()`here will earn us some points.

## Lesson learnt


### Bonus track
