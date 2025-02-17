// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*函数计算
*/
 
 contract HelloEp2 {

    // 加
     function add(uint a,uint b) public pure returns (uint) {
        return a + b;
     }
    //减
     function sub(uint a,uint b) public pure returns (uint) {
        return a - b;
     }
    //乘
     function mul(uint a,uint b) public pure returns(uint) {
        return a * b;
     }
     //除
     function div(uint a,uint b) public pure returns(uint) {
        return a/b;
     }
    //多返回值
     function val(uint a,uint b,uint c) public pure returns (uint,uint,uint) {
        return (a,b,c);
     }

     function getName() public pure returns (string memory) {
        return _getName();
     }

     function _getName()private pure returns (string memory) {
        return "i am zhoumuhao";
     }
 }
