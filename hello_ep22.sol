// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/**
**回退函数
*/
contract callBackFun {

    //定义一个事件
    event Log(string name,bytes data);

    //payable  加入 payable  收取费用
   fallback() external  payable{
        emit Log("fallback",msg.data);
    }


    
}