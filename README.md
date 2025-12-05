🎟️ Decentralized Lottery Smart Contract
Built with Solidity · Transparent · Trustless · Automated

This project implements a fully decentralized lottery system using Solidity.
Players enter by paying a fixed entry fee, and a winner is selected using on-chain pseudorandomness.
All transactions, entries, and payouts happen automatically and transparently on the Ethereum blockchain — removing the need for any centralized authority.

🚨 Why Traditional Lotteries Are a Problem

Traditional lotteries depend on a central organization for ticket handling, number generation, prize distribution, and result announcements.
This creates issues such as:

Lack of transparency — players cannot verify if results are fair.

Risk of manipulation — results or payouts can be changed behind the scenes.

Slow payouts — winners may wait days/weeks to receive funds.

High administrative overhead — systems rely on manual/centralized processes.

✅ How This Decentralized Lottery Solves It

The smart contract removes all middlemen and automates the entire lottery through code:

100% transparency — all entries and payouts are visible on-chain.

Fair winner selection — pseudorandomness from blockchain data prevents manipulation.

Instant payouts — the winner automatically receives the entire prize pool.

Immutable rules — once deployed, no one can secretly alter the lottery logic.

This ensures a trustless, secure, and verifiable lottery experience.

📌 Features
1. Participation

Anyone can join by calling enter() and sending exactly entryFee.

Every entry is recorded on-chain.

2. Winner Selection

Only the owner can call pickWinner().

Winner is chosen using:

keccak256(block.timestamp, blockhash(block.number - 1), players.length)


Winner automatically receives the entire contract balance.

Lottery resets after each round.

3. Contract State

players: dynamic list of participants.

entryFee: required ETH amount.

owner: deploying address.

isOpen: prevents entries during winner selection.

(Details sourced from Section 2 of your assignment PDF) 

2024SL93093_BLOCKCHAIN_TECHNOLO…

🧩 Smart Contract Code

Full contract is available in contracts/Lottery.sol.

Key characteristics:

Uses Solidity ^0.8.20

Emits events for transparency (PlayerEntered, WinnerPicked)

Includes helper functions to open/close the lottery for testing

Code taken from Section 3 of your PDF. 

2024SL93093_BLOCKCHAIN_TECHNOLO…

🧪 Unit Tests (Remix Solidity Tests)

You have complete positive and negative test coverage, including:

✔ Positive Tests

Enter with correct ETH

Multiple entries

Owner triggers winner selection

Contract resets correctly

✖ Negative Tests

Enter with insufficient ETH

Enter when lottery is closed

Non-owner calling pickWinner()

Calling pickWinner() with zero players

(These test cases appear in Section 4 of your assignment.) 

2024SL93093_BLOCKCHAIN_TECHNOLO…

Test code is stored in tests/Lottery_test.sol.

🚀 Deployment Guide (Remix)

Deployment steps summarized from Section 6 of your PDF: 

2024SL93093_BLOCKCHAIN_TECHNOLO…

Open Remix

Create contracts/Lottery.sol

Compile using Solidity 0.8.18+

Deploy using Remix VM (Prague)

Pass 1 ether (or custom fee) as constructor argument

Players call enter()

Owner calls pickWinner()

🧭 Running Tests

From Section 7 of your PDF: 

2024SL93093_BLOCKCHAIN_TECHNOLO…

Enable Solidity Unit Testing plugin

Create tests/Lottery_test.sol

Click Run Tests

Green = passed ✔

Red = failed ❌

📸 Screenshots

Include the screenshots shown in your assignment (page 10).
They show:

Contract deployment

Unit test results

🏁 Conclusion

This project demonstrates:

A fully decentralized lottery using Solidity

Secure and transparent participation

Automatic and fair winner selection

Strong validation and test coverage

Clear deployment and testing workflow
