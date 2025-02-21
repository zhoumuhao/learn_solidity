// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
** 哈希函数
**/
contract HelloEp24 {

    /*
    *相当于区块链中的md5函数
    */
    function test(uint a,string memory b) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(a,b));
    }

    //判断两个值是否相等
    function cmp(string memory a,string memory b) public pure returns (bool) {
        return keccak256(bytes(a))==keccak256(bytes(b));
    }
    
}