// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Lottery {
    address public owner;
    address[] public players;
    uint256 public entryFee;
    bool public isOpen;

    event PlayerEntered(address indexed player);
    event WinnerPicked(address indexed winner, uint256 amount);

    constructor(uint256 _entryFee) {
        owner = msg.sender;
        entryFee = _entryFee;
        isOpen = true;
    }

    function enter() external payable {
        require(isOpen, "Lottery closed");
        require(msg.value == entryFee, "Insufficient fee");

        players.push(msg.sender);
        emit PlayerEntered(msg.sender);
    }

    function getPlayers() external view returns (address[] memory) {
        return players;
    }

    function playersCount() external view returns (uint256) {
        return players.length;
    }

    function pickWinner() external {
        require(msg.sender == owner, "Not owner");
        require(players.length > 0, "No players");
        require(isOpen, "Lottery closed");

        isOpen = false;

        uint256 winnerIndex = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, blockhash(block.number - 1), players.length)
            )
        ) % players.length;

        address winner = players[winnerIndex];
        uint256 prize = address(this).balance;

        payable(winner).transfer(prize);

        emit WinnerPicked(winner, prize);

        // Reset state
        delete players;
        isOpen = true;
    }

    // Helper function to manually close lottery (for testing)
    function closeLottery() external {
        require(msg.sender == owner, "Not owner");
        isOpen = false;
    }

    // Helper function to manually open lottery (for testing)
    function openLottery() external {
        require(msg.sender == owner, "Not owner");
        isOpen = true;
    }
}
