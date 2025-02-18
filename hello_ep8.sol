// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* 全局变量

        eth units
        1 wei = 1
        1 gwei = 1e9 wei
        1 eher  = 1e18 wei

        time units
        1 seconds = 1
        1 minutes = 60 seconds
        1 hours = 60 minutes
        1 day = 24 hours
        1 week = 7 days

        block.number uint
        block.timestamp uint 15s
        block.difficulty uint
        block.coinbase address payable
        block.chainid uint
        block.gaslimit uint 20 000 000

        msg.data  bytes
        msg.sender addresss
        msg.isg bytes4 //test transfer test(uint,uint)
        msg.value uint //wei

        tx.gasprice uint
        tx.origin  address     user=> a.b() => b.c()
                               msg.sender  msg.sender = a.address
                               te.orign    tx.orign = user
**/
contract GlobalVarsEp8 {
    
}