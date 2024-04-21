// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DDcoin {
    address public owner; // Address of the contract owner
    mapping(address => uint) public balance; // Mapping to store account balances
    mapping(address => bool) public isSafe; // Mapping to track account safety status

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Event emitted when a transfer occurs
    event Sent(address from, address to, uint amount);

    // Event emitted when an account is blocked or unblocked
    event Block_UnBlock(address account);

    // Function to add new coins to an account (only callable by owner)
    function addNewcoin(address receiver, uint amount) public {
        require(msg.sender == owner, "Only owner can add new coins");
        balance[receiver] += amount;
    }

    // Function to transfer coins between accounts (only callable by owner and if sender is marked safe)
    function transfer(address receiver, uint amount) public {
        require(msg.sender == owner, "Only owner can access");
        require(isSafe[msg.sender] == true, "Sender is not marked safe");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    // Function to view the balance of an account (only callable by owner)
    function viewBalance(address account) public view returns(uint) {
        require(msg.sender == owner, "Only owner can access");
        return balance[account];
    }

    // Function to block an account (only callable by owner)
    function blockAccount(address client) public {
        require(msg.sender == owner, "Only owner can access");
        isSafe[client] = false;
        emit Block_UnBlock(client);
    }

    // Function to unblock an account (only callable by owner)
    function unblockAccount(address client) public {
        require(msg.sender == owner, "Only owner can access");
        isSafe[client] = true;
        emit Block_UnBlock(client);
    }
}
