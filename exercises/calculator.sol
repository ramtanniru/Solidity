// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract calculator{
    int res;

    constructor(){
        res = 0;
    }

    function add(int a) public{
        res += a;
    }

    function subtract(int a) public {
        res -= a;
    }

    function multiply(int a) public{
        res *= a;
    }

    function divide(int a) public{
        if(a!=0){
            res /= a;
        }
    }

    function getResult() view public returns (int){
        return res;
    }

}