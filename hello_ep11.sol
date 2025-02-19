// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*映射
*/
contract HelloEp11 {

    //简单映射
    mapping (uint=>address) users;

    //双重映射
    mapping (address=>mapping (address=>uint8)) frends;

    //设置user
    function setUser(uint k,address addr) public returns(address){
        users[k] = addr;
        return addr;
    }

    //获取user
    function getUser(uint k) public view returns(address) {
        return  users[k];
    }

    //删除user
    function removeUser(uint k) public returns (bool) {
        delete users[k];
        return true;
    }

    //新增朋友
    function addFriend(address addr) public returns (bool) {
        frends[tx.origin][addr] = 1;
        frends[addr][tx.origin] = 2;
        return true;
    }

    //获取朋友 状态
   function getFriendStatus(address addr) public view returns(uint8) {
        return frends[tx.origin][addr];
    }

    //设置状态
    function setFriend(address u,address v) public returns (uint8){
        return frends[u][v] = 2;
    }

    //删除friends
    function deleteFriend(address u ,address v) public returns (bool) {
        delete frends[u][v] ;
        return true;
    }

  
}