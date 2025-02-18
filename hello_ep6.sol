// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
* 断言 与 错误处理    assert 与 require   条件内为false 会触发
*TODO::断言 assert 不要轻易使用，会强制把gass收了。但是 revert 和 require 不会
*/
contract HelloEp6 {

    error onlyLess(string v);

    //断言
    function test(uint a) public pure returns (uint) {
        //如果大于6 才返回 结果  否则报错
        assert(a>6);
        return a;
    }

    //错误 revert
    function test1(uint b) public pure returns (uint) {
        //不能用中文
        if(b>10) revert("only less 10");

        return b;
    }

    function test2(uint c) public pure returns(uint) {
        // 当 条件为 false的时候会触发
        require(c<=10, "only less than 10");
        return c;
    }

    //抛出错误
    function test3(uint d) public pure returns (uint) {
        if(d>10) revert onlyLess(" d less 10");
        return d;
    }

}