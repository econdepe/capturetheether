# Lotteries

The structure of all the challenges in this section is the same. Someone has coded a lottery into a smart contract, initially
deployed with a 1 ether balance (we will have to pay for this). Playing this lottery costs 1 ether, and we are rewarded 2 ether
if we win it. The challenge is completed when the balance of the lottery smart contract is 0 ether, which can only occur if our
first guess is correct (of course we assume we are the only ones playing the lottery! :wink:).

Although ether in Ropsten costs nothing, it may be a bit annoying to keep getting it from the faucet to play these games,
especially if you have to try several times until you get the right solution. A good
strategy is to simulate the games in the Javascript Virtual Machine (VM) that Remix provides. Remix creates a test Ethereum
environment running in the cloud (analogous to the test environment we could set in our own computer for instance with Truffle).
We are assigned 5 accounts with
100 ether each, and we can use them to deploy the contracts and interact with them at totally zero cost, and without having to
wait for transactions to be mined. Once we are sure the logic of our strategy is correct, we can implement it in the Ropsten
network with the real game.
