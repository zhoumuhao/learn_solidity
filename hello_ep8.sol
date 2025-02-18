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

    function test() public view returns (uint,uint,uint,address,uint,uint) {
        return (block.number /*区块节点*/,block.timestamp /*时间戳*/,block.prevrandao,block.coinbase /*打包人地址*/,block.chainid,block.gaslimit /*gas上限*/);
    }

    function echo(uint a) public view returns (uint,address,bytes memory,bytes4) {
        return(a,msg.sender,msg.data /*整个函数的信息*/,msg.sig /*函数参数签名*/);
    }

    function echoData() public view returns (address,uint) {
        return (tx.origin,tx.gasprice);
    }
}