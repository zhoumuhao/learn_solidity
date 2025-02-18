// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
* 函数修改器 用于 执行函数之前
**
*/
contract FunctionModifierEp7 {

    bool isLock;

    //地址特有类型
    address owner = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    //判断条件
    modifier isLegal(uint a) {
        require(a>=10,"a less than 10");
        _;  //执行调用该修改器的函数
    }

    //逻辑执行加锁
    modifier isLocked() {
        require(!isLock, "the function is lock");
        isLock = true;
        _;
        isLock = false;
    }

    //判断是否是管理员
    modifier isOwner() {
        require( msg.sender == owner, "Permission denied");
        _;
    }

    //执行函数之前先执行 isLegal
    function test(uint a) public isLegal(a) pure returns (uint) {
        return a;
    }

    /**
    *判断是否上锁
    */
    function test1(uint b) public isLocked()  returns (uint) {
        return b;
    }

    /*
    * 判断是否是管理员
    */
    function isOwnerFun() public isOwner() view returns (bool){
        return true;
    }

}