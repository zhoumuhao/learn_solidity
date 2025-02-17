// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*流程控制
*/
contract HelloEp3 {
    // if...else...
    function test(uint a) public pure returns(uint){
        if(a>=1 && a<6) {
            return 4;
        }
        else if(a>=6 && a<10) {
            return 8;
        }
        else {
            return 20;
        }
    }

    //三元运算法
    function test1(uint b) public pure returns (bool) {
        return b>10?true:false;
    }

    
}