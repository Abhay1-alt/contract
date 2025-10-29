# contract
build a Blockchain-based savings account with transaction history.
# 💰 Fillloos - Blockchain-Based Savings Account with Transaction History

**Fillloos** is a beginner-friendly Solidity smart contract that allows users to **save Ether**, **withdraw funds**, and **track their full transaction history** — all directly on the blockchain.  
It acts like a **decentralized savings account**, where users have full control of their funds.

---

## 🧩 Features

- 💸 **Deposit Ether** into your blockchain-based savings account  
- 💰 **Withdraw funds** securely anytime  
- 🧾 **Transaction history tracking** (with timestamps and type)  
- 🔐 **User-specific balances** stored on-chain  
- 🧠 **Beginner-friendly Solidity code** — perfect for learning  

---

## 🧠 Smart Contract Overview

| Function | Description |
|-----------|--------------|
| `deposit()` | Deposit Ether to your Fillloos account |
| `withdraw(uint amount)` | Withdraw a specific amount of Ether |
| `getBalance()` | View your current account balance |
| `getTransactionHistory()` | Retrieve your deposit and withdrawal history |

Each transaction record includes:
- **Amount (in Wei)**
- **Transaction Type** — “Deposit” or “Withdraw”
- **Timestamp** — When it occurred

---

## ⚙️ Tech Stack

- **Solidity v0.8.x** — Smart contract language  
- **Remix IDE** — For writing, compiling, and deploying  
- **EVM-compatible blockchain** — (Ethereum, Sepolia, Polygon, etc.)

---

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6a7f4685-632c-4f48-93fe-a84ec500f3b9" />


## 🚀 How to Deploy on Remix

1. Open [Remix Ethereum IDE](https://remix.ethereum.org)
2. Create a new file named `Fillloos.sol`
3. Copy and paste the full contract code:

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.0;

   contract Fillloos {
       struct Transaction {
           uint256 amount;
           string txnType;
           uint256 timestamp;
       }

       mapping(address => uint256) public balances;
       mapping(address => Transaction[]) private transactionHistory;

       function deposit() external payable {
           require(msg.value > 0, "Deposit must be greater than 0");
           balances[msg.sender] += msg.value;
           transactionHistory[msg.sender].push(Transaction(msg.value, "Deposit", block.timestamp));
       }

       function withdraw(uint256 amount) external {
           require(amount > 0, "Withdrawal must be greater than 0");
           require(balances[msg.sender] >= amount, "Insufficient balance");
           balances[msg.sender] -= amount;
           payable(msg.sender).transfer(amount);
           transactionHistory[msg.sender].push(Transaction(amount, "Withdraw", block.timestamp));
       }

       function getBalance() external view returns (uint256) {
           return balances[msg.sender];
       }

       function getTransactionHistory() external view returns (Transaction[] memory) {
           return transactionHistory[msg.sender];
       }
   }
