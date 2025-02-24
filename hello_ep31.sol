// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Student {

    
}

/**
* create2部署合约
*  合约地址生成法
*  bytes memory packed = abi.encodePacked(
     uint8(0xff), //255
     address(this), 
     salt, //byte32
     keccak256(creationCode)  //bytes32
);
*  bytes32 hash = kecck256(packed);
*  address = new Address = address(uint160(uint(hash)))
*/
contract Create2ByCreationCodeEp31 {

    
}