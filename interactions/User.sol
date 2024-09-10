// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    
    struct Player {
        address playerAddress;
        string username;
        uint score;
    }
    
    mapping(address => Player) public players;

    function createUser(address _userAddress,string memory _name) external {
        require(players[_userAddress].playerAddress == address(0), "User already exists");
        
        Player memory newPlayer = Player({
            playerAddress: _userAddress,
            username: _name,
            score: 0
        });

        players[_userAddress] = newPlayer;
    }
}