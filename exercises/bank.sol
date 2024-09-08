// SPDX-License-Identifier: UNLICENSED
pragma solidity>=0.4.16;

contract bank{
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;
    constructor(){
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier isPaused(){
        require(paused==false,"Your account is paused");
        _;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"You are not owner");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }


    function getBal(address user) view public returns (uint){
        return balances[user];
    }

    function transfer(address _to, uint amt) public isPaused {
        address currOwner = msg.sender;
        require(balances[currOwner]>=amt,"Insufficient balance");
        balances[currOwner] -= amt;
        balances[_to] += amt;
    }

}