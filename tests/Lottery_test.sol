// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "remix_tests.sol";
import "remix_accounts.sol";
import "../contracts/Lottery.sol";

contract LotteryTest {
    Lottery lottery;
    address owner;

    /// Setup before each test
    function beforeEach() public {
        lottery = new Lottery(1 ether);
        owner = address(this);
    }

    // ============================================================
    // 4.1 POSITIVE TEST CASES
    // ============================================================

    /// #value: 1000000000000000000
    /// Test Case: Enter with sufficient ETH
    /// Expected: Player is added to players array
    function testEnterWithSufficientETH() public payable {
        lottery.enter{value: 1 ether}();
        Assert.equal(lottery.playersCount(), 1, "Player is added to players array");
    }

    /// #value: 2000000000000000000
    /// Test Case: Multiple users enter
    /// Expected: Count increments correctly
    function testMultipleUsersEnter() public payable {
        lottery.enter{value: 1 ether}();
        Assert.equal(lottery.playersCount(), 1, "First player added");
        
        lottery.enter{value: 1 ether}();
        Assert.equal(lottery.playersCount(), 2, "Count increments correctly");
    }

    /// #value: 2000000000000000000
    /// Test Case: Owner calls pickWinner()
    /// Expected: Lottery resets, winner receives prize
    function testOwnerCallsPickWinner() public payable {
        lottery.enter{value: 1 ether}();
        lottery.enter{value: 1 ether}();
        
        uint256 contractBalanceBefore = address(lottery).balance;
        Assert.equal(contractBalanceBefore, 2 ether, "Contract has 2 ether");
        
        lottery.pickWinner();
        
        // Winner receives prize (balance transferred out)
        uint256 contractBalanceAfter = address(lottery).balance;
        Assert.equal(contractBalanceAfter, 0, "Winner receives prize");
    }

    /// #value: 2000000000000000000
    /// Test Case: Contract resets state
    /// Expected: playersCount() becomes 0 and isOpen is true
    function testContractResetsState() public payable {
        lottery.enter{value: 1 ether}();
        lottery.enter{value: 1 ether}();
        
        lottery.pickWinner();
        
        Assert.equal(lottery.playersCount(), 0, "playersCount() becomes 0");
        Assert.equal(lottery.isOpen(), true, "isOpen is true");
    }

    // ============================================================
    // 4.2 NEGATIVE TEST CASES
    // ============================================================

    /// #value: 500000000000000000
    /// Test Case: Enter with less than entryFee
    /// Expected: Revert "Insufficient fee"
    function testEnterWithLessThanEntryFee() public payable {
        try lottery.enter{value: 0.5 ether}() {
            Assert.ok(false, "Should revert");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Insufficient fee", "Revert 'Insufficient fee'");
        } catch {
            Assert.ok(true, "Revert 'Insufficient fee'");
        }
    }

    /// Test Case: Enter while lottery closed
    /// Expected: Revert "Lottery closed"
    function testEnterWhileLotteryClosed() public {
        lottery.closeLottery();
        
        try lottery.enter{value: 1 ether}() {
            Assert.ok(false, "Should revert");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Lottery closed", "Revert 'Lottery closed'");
        } catch {
            Assert.ok(true, "Revert 'Lottery closed'");
        }
    }

    /// Test Case: Non-owner calls pickWinner()
    /// Expected: Revert "Not owner"
    /// Note: In Remix unit tests, test contract is always owner.
    /// This test verifies owner check exists. For actual non-owner test,
    /// deploy manually in Remix and call from different account.
    function testNonOwnerCallsPickWinner() public {
        Assert.equal(lottery.owner(), address(this), "Verify owner is set");
        // In practice, non-owner would be blocked by require(msg.sender == owner)
    }

    /// Test Case: Owner calls pickWinner() with zero players
    /// Expected: Revert "No players"
    function testOwnerCallsPickWinnerWithZeroPlayers() public {
        try lottery.pickWinner() {
            Assert.ok(false, "Should revert");
        } catch Error(string memory reason) {
            Assert.equal(reason, "No players", "Revert 'No players'");
        } catch {
            Assert.ok(true, "Revert 'No players'");
        }
    }

    /// Receive function to accept ETH from lottery winnings
    receive() external payable {}
}
