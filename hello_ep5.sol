// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloEp5 {

    uint public id;

    //设置id
    function setId(uint _id) public returns (bool) {
        id = _id;
        return true;
    }

    //获取id
    function getId() public view  returns(uint) {
        return id;
    }

    
}