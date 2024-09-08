// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventExample {
    
    struct User{
        string name;
        uint age; 
    }

    mapping(address=>User) public users; 

    event NewRegUser(address indexed user,User newUser);

    function addUser(string memory _name,uint _age) public {
        User memory newUser = User({
            name: _name,
            age: _age
        });

        emit NewRegUser(msg.sender, newUser);
    }

} 