// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*工厂合约
*/
contract Goods {

    string name;

    constructor(string memory _name) {
        name = _name;
    }

    function getName()public view returns (string memory) {
        return name;
    }
}

contract FactoryEp15 {

    Goods[] public goodList;

    /*
    *新增商品列表
    */
    function makeGoods(string memory _name) public returns(Goods) {
       Goods goods =  new Goods(_name);
       goodList.push(goods);
       return goods;
    }

    /**
    *获取 good信息
    */
    function callGoodsName(uint k) public view returns (string memory) {
        if(k<goodList.length) return goodList[k].getName();
        return "";
    }
    
}