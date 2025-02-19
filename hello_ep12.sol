// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*
**枚举和常量
**/
contract HelloEp12 {
    //设置一个枚举
    enum State {Default, Pending,success }


    uint public id;
    //设置一个常量
    uint public constant GENDER = 1;


    State public state;


    //设置常量
    function setState(State _state) public returns (State) {
        state = _state;
        return state;
    }

    //重置state
    function resetState() public returns(State){
        delete state;
        return state;
    }

    //获取枚举最小值
    function getStateMin()public pure returns(uint8) {
        return uint8(type(State).min);
    }

    //获取枚举最大值
    function getStateMax()public pure returns(uint8) {
        return uint8(type(State).max);
    }









}