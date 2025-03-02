// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
**  多签钱包
*/
contract MultiSignEp34 {

    enum State {
        Pending,  //交易执行中
        Approved, //交易已同意
        Rejected  //交易已拒绝
    }

    //签名者信息
    struct Signer {
        address account;  //签名人
        State  state; //签名状态
        uint  signedAt;  //签名时间
    }

    //交易信息
    struct Transaction {
        uint id;
        string title;  //转账标题
        uint value; //eth值
        bytes data; //是否执行合约
        Signer[] Signer; //签名者
        State state; //状态
        uint[3] timeAt; //ApprovedAt  rejectedAt createdAt
    }


    
}