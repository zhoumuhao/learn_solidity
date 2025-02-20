// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*不可变量
* 比较省gas
*/
contract HelloEp18 {

    //定义常量
    string public constant name = "LI_LEI";


   //定义普通的变量
   int public id;

   //定义不可变量   非值类型
   uint public immutable gender = 1;

    //不可变量可以构造器赋值
   constructor(uint _a) {
    gender = _a;
   }

}