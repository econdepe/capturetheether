# CHALLENGE : CALL ME

Now that we have learnt to deploy smart contracts, next task is obvious to call their functions. We will use Remix for making
the call.

## Steps to follow

1. First we deploy on the Ropsten network the smart contract *CallMe* by clicking on "Begin Challenge". The address of the
contract will be displayed after the deployment has been confirmed.
2. To interact with the deployed contract via Remix we are going to load it there***. For that we copy the smart contract in a
new .sol file in the Remix folder "browser". Then we compile it (you can ignore the warnings) in the "Compile" tab on the right.
This will make it appear in the list of compiled contracts in the "Run" tab. We enter the Ropsten address we obtained before and
click "At Address". The contract will be successfully loaded if it appears in "Deployed contracts".
3. Clicking on the deployed contract we get access to all the public functions in the contract as well as getters of public
variables (a getter is a function that returns the value of the variable). Calling them is done with a
simple click. The goal of this challenge is to make the boolean `isComplete = true`. This is easily achieved by calling (at least)
once the function `callme`.
4. You can check using its getter that the value of the variable `isComplete` is `true`. Click on "Check solution" to end the
challenge.

### *** Loading deployed contracts in Remix
To load in Remix a contract that has been deployed in some network, we need access to that network and its ABI (ABI stands for
Application Binary Interface; it essentially contains the information about the functions and variables contained in a contract
written in a machine-friendly way; read more [here](https://solidity.readthedocs.io/en/v0.4.21/abi-spec.html#)). You can follow
the instructions in https://remix.readthedocs.io/en/latest/run_tab.html#using-the-abi.

However, if we have access to the smart contract (Solidity) source code, we don't need to pass through its ABI. We can simply
compile the contract and use the "At Address" button as we described in point 2 above.

It is not usual to have access to smart contracts source code or ABI (see https://etherscan.io/contractsVerified for contracts
with public source code and ABI). The advantage of the ABI over the source code is that it
is universal (source code could be written in other languages like Vyper or Serpent).
