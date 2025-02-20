// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*自毁函数(已弃用)
**/
contract HelloEp23 {

    //支付
   receive() external payable { }

    //自毁
   function kill() external {
        selfdestruct(payable (msg.sender));
   }

   function hello() public pure returns (string memory){
    return "hello";
   }
    
}