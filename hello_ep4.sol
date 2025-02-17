// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*循环
*/
contract HelloEp4 {

    event Dump(uint n);

    function test(uint a)public returns (uint) {
        for (uint i; i<a; i++) 
        {
           emit Dump(i);
        }
        return a;
    }

    function test2(uint b) public returns(uint) {
        uint c;
        while (c<b) {
            emit Dump(c);
            c++;
        }
        return b;
    }

    
}