🎟️ Decentralized Lottery Smart Contract
A Transparent, Trustless, and Automated Blockchain Lottery
<p align="center"> <img src="https://img.shields.io/badge/Solidity-0.8.20-black?style=for-the-badge&logo=ethereum" /> <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" /> <img src="https://img.shields.io/badge/Platform-Remix-orange?style=for-the-badge&logo=visualstudiocode" /> </p>
🌟 Overview

This project implements a fully decentralized lottery using Solidity.
Players enter by paying a fixed entry fee, and the smart contract automatically selects a winner using pseudorandom blockchain data.

✨ No central authority. No manual payouts. No manipulation.
Everything is transparent, automated, and permanently recorded on-chain.
(Information taken from your assignment introduction) 

2024SL93093_BLOCKCHAIN_TECHNOLO…

❗ Why Traditional Lotteries Are a Problem

Traditional lotteries suffer from several issues:

❌ Players cannot verify fairness

❌ Results can be manipulated by centralized authorities

❌ Payouts are slow and sometimes unclear

❌ System is opaque and trust-based

✅ How This Smart Contract Solves It

The decentralized lottery brings fairness and transparency through blockchain:

✔ On-chain record of every entry

✔ Automated winner selection using keccak256 randomness

✔ Instant prize payout to winner

✔ Immutable rules — no human interference

This makes the system trustless, verifiable, and far more reliable than traditional lottery systems.

⚙️ Smart Contract Features
🎫 1. Entering the Lottery

Anyone can join with enter()

Must send exactly entryFee

Each player’s address is added to the on-chain players list

🏆 2. Winner Selection

Only the owner can call pickWinner()

Winner is chosen using blockchain data:

keccak256(
  abi.encodePacked(block.timestamp, blockhash(block.number - 1), players.length)
)


Entire contract balance is transferred to the winner

Lottery resets for the next round
(Section 2 of your assignment) 

2024SL93093_BLOCKCHAIN_TECHNOLO…

📌 3. Contract State Variables

players: dynamic list of participants

entryFee: cost to enter

owner: address that deployed the contract

isOpen: indicates whether entries are allowed

📂 Project Structure (Suggested)
.
├── contracts/
│   └── Lottery.sol
├── tests/
│   └── Lottery_test.sol
├── README.md

🧪 Test Coverage (Remix Solidity Tests)

Your project includes complete test coverage:

✔ Positive Tests
Test Case	Expectation
Enter with sufficient ETH	Player added
Multiple users enter	Count increments
Owner picks winner	Winner receives prize
Lottery resets	playersCount = 0, isOpen = true
❌ Negative Tests
Test Case	Expectation
Enter with less than entryFee	Revert "Insufficient fee"
Enter while lottery closed	Revert "Lottery closed"
Non-owner calling pickWinner	Revert "Not owner"
pickWinner with no players	Revert "No players"

(Section 4 & test file content) 

2024SL93093_BLOCKCHAIN_TECHNOLO…

🚀 Deployment Guide (Remix)
1️⃣ Open Remix

👉 https://remix.ethereum.org

2️⃣ Create Contract

Location: contracts/Lottery.sol

Paste code

3️⃣ Compile

Compiler: Solidity 0.8.18+

4️⃣ Deploy

Environment: Remix VM (Prague)

Constructor input: 1 ether

Click Deploy

5️⃣ Interact

Players call: enter()

Owner calls: pickWinner()

(From Section 6 in your assignment PDF) 

2024SL93093_BLOCKCHAIN_TECHNOLO…

🧭 Running Tests

Enable Solidity Unit Testing Plugin

Add tests/Lottery_test.sol

Run all test cases

View pass/fail results

This project successfully demonstrates a:

✔ Fully decentralized lottery

✔ Automated and fair winner selection

✔ Trustless payout system

✔ Strong test coverage

✔ Complete deployment and execution workflow
