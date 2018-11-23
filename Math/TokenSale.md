# CHALLENGE : TOKEN SALE

We are given a smart contract which simulates a token factory, where we can buy, and to which we can sell. Each token costs 1
ether, and we can only trade it with the factory. The smart contract is initialized with 1 ether, and the challenge is to
reduce this initial balance.

## Strategy

A priori reducing the initial balance of the contract looks like an impossible task since the only operations allowed are the
purchase of tokens (which increase the initial balance) and their sale (which at most simply restore the initial balance). The
trick must be in the implementation of these operations.

Indeed, no attention at all has been paid to possible integer overflows. Imagine the maximum value an unsigned (i.e.:
positive) integer can attain is N. Who is N+1? Solidity interprets N+1=0, N+2=1, N+3=2, etc. This is very dangerous
as we pass from a very big number to a very small one by simply adding one.

For the particular smart contract under consideration, integer overflow can be exploited in the function `buy`. Buying a number
of tokens X, such that X > 2^256/10^18 only costs (X*10^18) % 2^256 wei, which is less than X ether (notice X < 2^256 to
avoid integer overflow for the number of tokens, we just want integer overflow in the price to pay). In this way we can "steal"
tokens from the factory, that we can then use to "steal" some of its money.

## Steps to follow

1. Deploy the smart contract by clicking "Begin Challenge". Its initial balance is 1 ether.
2. Buy [2^256/10^18] + 1 tokens ([·] stands for integer part). Because ([2^256/10^18] + 1) * 10^18 % 2^256 = 415992086870360064,
the price we need to pay for this operation is only `415992086870360064 wei = 0.415992086870360064 ether`, making the contract
balance equal to ~1.416 ether.
3. Now we are owners of a zillion ([2^256/10^18] + 1 to be precise ;) ) tokens. If we sell simply one, we'll get 1 ether back
from the contract, leaving its balance equal to ~0.416 ether. Calling `isComplete()`here will earn us some points.

## Lesson learnt

Maths have arbitrary precision. Computers do not. We must take this nuance into account every time we implement math
operations in our smart contracts. Integer overflow is a well-known issue in different programming languages, and Solidity is
no exception.

For this particular example, there is only one place where integer overflow could occur with dangerous
consequences, which is in the function `buy`. It would be enough to include a *throw error* statement when integer overflow
happened, but a wider-scope solution would be to use a library that automatically throws errors in case of integer overflows.
Such a library exists, and it is called [SafeMath](
https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol).

### Bonus track

The challenge has been solved, but the solution is not unique. Namely, how much balance should be left in the smart contract?
The challenge only asks this balance to be less than 1 ether, but a natural question would be whether we can "steal" all its
money (after all, we payed for this money!). Indeed, once the TokenSaleChallenge smart contract has been deployed, it is
possible to search in https://etherscan.io/ for similar contracts. We will see in there all the smart contracts deployed by
people playing this game, and we can see their balance. Many of them will have ~0.416 ether, so those have used the strategy
commented above. But some will have 0 ether! How can we be greedy and do that as well?

As we said above, buying X tokens costs us (X*10^18) % 2^256 wei. If we make this price equal to an integer number of ethers,
we will be able to recover that money later by selling tokens (we can only sell an integer number of them).  In particular,
if we want to pay 1 ether = 10^18 wei, we need X such that (X*10^18) % 2^256 = 10^18, or equivalently
X\*10^18 - 10^18 = 2^256\*K, where K is some positive integer. There are many solutions to this Diophantine equation, but a
simple one is X = 2^238 + 1, K = 5^18. Therefore, if we buy 2^238 + 1 tokens, and then sell 2 of them, we will empty
the balance of the TokenSaleChallenge smart contract. :trollface:
