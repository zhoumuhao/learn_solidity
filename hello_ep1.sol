// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloEp1 {

    int public key = -1;

    uint public id = 1;

    string public name = "hello";

    bool public isActive = false;

    mapping (uint => bool) blocked;

    // struct User {
    //     name : "zhou"
    // }

    bytes public data;

    enum State {DEFAULT,FAILBACK}

    address public addr;

    int[] public list;

}