// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Fillloos - A Blockchain-based Savings Account with Transaction History
/// @notice This contract lets users deposit, withdraw, and view their transaction history on-chain.
/// @dev Beginner-friendly Solidity example.

contract Fillloos {

    // Structure to store each transaction
    struct Transaction {
        uint256 amount;      // Amount of Ether involved
        string txnType;      // "Deposit" or "Withdraw"
        uint256 timestamp;   // When the transaction occurred
    }

    // Mapping from user address to balance
    mapping(address => uint256) public balances;

    // Mapping from user address to their transaction history
    mapping(address => Transaction[]) private transactionHistory;

    /// @notice Deposit Ether into your Fillloos savings account
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        // Update user's balance
        balances[msg.sender] += msg.value;

        // Log the deposit transaction
        transactionHistory[msg.sender].push(
            Transaction(msg.value, "Deposit", block.timestamp)
        );
    }

    /// @notice Withdraw Ether from your Fillloos account
    /// @param amount The amount to withdraw (in wei)
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Deduct from user's balance
        balances[msg.sender] -= amount;

        // Transfer Ether back to the user
        payable(msg.sender).transfer(amount);

        // Log the withdrawal transaction
        transactionHistory[msg.sender].push(
            Transaction(amount, "Withdraw", block.timestamp)
        );
    }

    /// @notice View your current balance
    /// @return Balance in wei
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    /// @notice Get your transaction history (all deposits and withdrawals)
    /// @return Array of all transactions
    function getTransactionHistory()
        external
        view
        returns (Transaction[] memory)
    {
        return transactionHistory[msg.sender];
    }
}
