// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*支付与收款
*/
contract HelloEp19 {

    //地址所对应的余额
    mapping (address=>uint) balance;


    receive() external payable { 
        deposit();
    }

    //充值金额
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    //提现
    function withdraw(uint v) public {
        require(v<=balance[msg.sender],"yu e bu zu");
        balance[msg.sender]-=v;
        payable(msg.sender).transfer(v);
    }

    //查询余额
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
}