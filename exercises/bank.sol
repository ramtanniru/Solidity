// SPDX-License-Identifier: UNLICENSED
pragma solidity>=0.4.16;

contract bank{
    uint bal;
    bool flag;
    string str;
    address node;
    constructor(){
        bal = 1;
    }
    function getBal() view public returns (uint){
        return bal;
    }
    function addBal(uint amt) public{
        bal += amt;
    }
    function delBal(uint amt) public{
        bal -= amt;
    }
}