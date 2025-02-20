// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
**  一大特性  事件
**/
contract HelloEp20 {

    //定义一个事件  indexed  地址被搜索到
    event Created(address indexed sender,uint timeAt);

    function creat(uint v) public returns (uint) {
        //触发事件
        emit Created(msg.sender,block.timestamp);
        return v;
    }
    
}