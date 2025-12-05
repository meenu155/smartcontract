// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Simple Lottery
/// @notice Players pay a fixed entry fee to join; the owner can pick a winner to receive the entire pot.
/// @dev Randomness is derived from block data and is NOT secure. Use Chainlink VRF or a commit-reveal scheme for production.
contract Lottery {
    /// @notice Address of the contract owner (deployer)
    address public owner;
    /// @notice List of players who entered the current round
    address[] public players;
    /// @notice Fixed fee in wei required to enter the lottery
    uint256 public entryFee;
    /// @notice Whether the lottery currently accepts new entries
    bool public isOpen;

    /// @notice Emitted when a player successfully enters the lottery
    /// @param player The address of the player who entered
    event PlayerEntered(address indexed player);
    /// @notice Emitted when a winner is selected and paid
    /// @param winner The address of the winner
    /// @param amount The prize amount transferred to the winner (in wei)
    event WinnerPicked(address indexed winner, uint256 amount);

    /// @param _entryFee The exact fee (in wei) required to enter the lottery
    constructor(uint256 _entryFee) {
        owner = msg.sender;
        entryFee = _entryFee;
        isOpen = true;
    }

    /// @notice Enter the lottery by paying exactly the entry fee
    /// @dev Reverts if lottery is closed or if msg.value does not equal entryFee
    function enter() external payable {
        require(isOpen, "Lottery closed");
        require(msg.value == entryFee, "Insufficient fee");

        players.push(msg.sender);
        emit PlayerEntered(msg.sender);
    }

    /// @notice Get the current list of players
    /// @return An array of player addresses
    function getPlayers() external view returns (address[] memory) {
        return players;
    }

    /// @notice Get the number of players in the current round
    /// @return The count of players who have entered
    function playersCount() external view returns (uint256) {
        return players.length;
    }

    /// @notice Pick a pseudo-random winner and transfer the entire contract balance
    /// @dev WARNING: Pseudo-randomness uses block data and is manipulable/predictable. Not suitable for real funds.
    ///      Consider Chainlink VRF or commit-reveal before mainnet use.
    function pickWinner() external {
        require(msg.sender == owner, "Not owner");
        require(players.length > 0, "No players");
        require(isOpen, "Lottery closed");

        isOpen = false;

        // Derive a pseudo-random index from block data and players length
        uint256 winnerIndex = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, blockhash(block.number - 1), players.length)
            )
        ) % players.length;

        address winner = players[winnerIndex];
        uint256 prize = address(this).balance;

        // Transfer the full contract balance to the winner
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
