# CHALLENGE: CHOOSE A NICKNAME

This challenge is a concrete example of calling a function of a deployed contract with a more credible purpose: we are going to
set up our name. That means that we are going to link our address (the address from where we are playing) with a name on the
smart contract run by capturetheether. This name may show up in the leaderboard if we accumulate enough points. :v:

## Steps to follow

1. First let's call the setNickname function of the contract CaptureTheEther. Since we are given its address, we load it in Remix
(it's enough to load the piece of the contract we are given) by running it using the option "At Address".
2. setNickname requires a `bytes32` as input, so we need to transform the string we have in mind for nickname to bytes32. This
is not easily done within Solidity, so it's better to use any other tool (you can simply use one of the many online converters).
For instance I chose 'mendalerenda' as my name. 'mendalerenda' reads as `0x6d656e64616c6572656e6461` in hex (the `0x`, which by
convention indicates that we are using hexadecimals, needs to be there for Solidity to recognise the input as `bytes32`).
3. We can now click on "Begin Challenge" (we could also click before steps 1 and 2). This prompts the CaptureTheEther contract
to deploy the NicknameChallenge contract (therefore `msg.sender` in the first line is the right contract address) passing it
our address. All of this happens behind the scenes.
4. Clicking on "Check Solution" will prompt the CaptureTheEther contract to call the `isComplete` function of the
NicknameChallenge. This function will return true given that we provided a username in step 2. The warmup is completed, and we
can now start fishing for real! :fish:
