// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Profile {
    struct UserProfile {
        string username;
        string bio;
    }

    mapping(address => UserProfile) public profiles;

    function setProfile(string memory _username, string memory _bio) public {
        profiles[msg.sender] = UserProfile({
            username: _username,
            bio: _bio
        });
    }

    function getProfile(address _user) view public returns (UserProfile memory) {
        return profiles[_user];
    }
}