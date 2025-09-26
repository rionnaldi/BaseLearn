// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract UnburnableToken {
    // Custom errors
    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address _to);

    // Storage variables
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    uint256 public totalClaimed;

    // Track which addresses have claimed tokens
    mapping(address => bool) private hasClaimed;

    // Constructor - sets total supply to 100,000,000
    constructor() {
        totalSupply = 100000000;
    }

    // Claim function - allows one-time claim of 1000 tokens per wallet
    function claim() public {
        // Check if user has already claimed
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        // Check if all tokens have been claimed
        if (totalClaimed + 1000 > totalSupply) {
            revert AllTokensClaimed();
        }

        // Mark user as having claimed
        hasClaimed[msg.sender] = true;

        // Add tokens to user's balance
        balances[msg.sender] += 1000;

        // Update total claimed
        totalClaimed += 1000;
    }

    // Safe transfer function with safety checks
    function safeTransfer(address _to, uint256 _amount) public {
        // Check if recipient is not zero address
        if (_to == address(0)) {
            revert UnsafeTransfer(_to);
        }

        // Check if recipient has ETH balance greater than zero
        if (_to.balance <= 0) {
            revert UnsafeTransfer(_to);
        }

        // Check if sender has enough tokens
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Perform the transfer
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
