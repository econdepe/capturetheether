# Deploy a contract

The idea of this challenge is to test that you know how to deploy a contract. We'll do that with Remix and Metamask.

## Deploy a contract

First of all, it's important to know that we'll be working (throughout all challenges) in the Ropsten test network**. We can
connect to this network in different ways:
1. Directly if we maintained a Ropsten node.
2. Connect through a known node. This could be done for example through an INFURA node: https://infura.io/
3. Through our browser (Chrome or Firefox are the only ones supported at the moment) with the Metamask extension. What
Metamask does, by the way, is to connect you through an INFURA node.
With options 1 and 2 we would have to talk to the Ropsten blockchain using the JSON-RPC language or with Javascript plus the
Web3 library. Metamask, together with Remix, offer us a much more "visual" way of interacting, just clicking buttons in our
browser. So we'll go with this option as the point here is to learn about smart contracts security, not about the Ethereum
blockchain innerworkings.

So open your Metamask, and deposit some ether from the faucet onto your account. By clicking now "Begin Challenge" in the capturetheether challenge,
your Metamask will open and ask you to pay some ether. You're paying the gas for calling a function in the CaptureTheEther smart
contract (that we'll never see) which will, in turn, deploy the contract you see on the right of the screen to the Ropsten
network. After the transaction is completed (i.e.: some Ropsten miner included it in a block), you will see the address of the
just-deployed contract. You can examine it in your favorite blockchain explorer.

## Complete Challenge

As we can see, the contract we just deployed is a very simple one. It contains a single function, isComplete, which upon calling will always return
true. By clicking "Check Solution", what we're secretly doing is calling another contract, CaptureTheFlag (again, we'll never
see its code), which in turn calls the function isComplete() of the contract we deployed above. If this call returns true,
then the smart contract CaptureTheFlag will assign us (i.e.: our Ropsten address) a number of points. In this case, 50 points!
At this point the challenge has been completed, and the webpage will show us presumably a joyful hacker ;)


### ** What is an Ethereum test network?

That's simply a blockchain with all the fundamental properties of the main Ethereum blockchain (some parameters,
such as block confirmation rate or consensus algorithm may vary), but where Ether has no value, i.e.: we can get it for free.
Of course the idea of having test networks is to play with smart contracts we may eventually deploy on the mainnet without risking
any money. Through Metamask we can connect to the Ropsten, Kovan and Rinkeby networks (additionally, there's the Sokol testnet).
Of these three, only Ropsten uses a Proof of Work consensus algorithm, so its behaviour is very similar to the mainnet.
The others use Proof of Authority. The drawback of using Proof of Work is that the network is more easily attacked (Ropsten was
indeed DoS attacked in February 2017), which makes it a bit more unstable.
