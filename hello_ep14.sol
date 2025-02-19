// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*多态与抽象
**/

//定义一个接口
interface user {
    //定义一个方法
     function getUser() external returns(string memory);
}

//定义一个抽象方法
abstract contract AbstractEp14 is user{

    function work() external virtual returns (uint8);
   
}

//定义一个父级合约类
contract ParentEp14 is AbstractEp14{

    uint public parentId;

    string public parentName;

    //构造方法
    constructor(uint _parentId,string memory _parentName) {
        parentId = _parentId;
        parentName = _parentName;
    }

    function getParentId() public  view returns (uint) {
        return parentId;
    }

    function getParentName() public view returns (string memory) {
        return parentName;
    }
    
    //实现接口
    function getUser() public pure returns (string memory) {
        return "this is student";
    }

    //实现抽象方法 关键字 override
    function work() public override pure returns (uint8) {
        return 1;
    }

}

//定义子类
contract HelloEp14 is ParentEp14 {

    uint public childId;

    string public childName;

    //构造方法，实现父类构造方法
    constructor(uint _id,string memory _name) ParentEp14(1,"parent:1") {
        childId = _id;
        childName = _name;
    }

    function getChildId() public  view returns(uint) {
        return childId;
    }

    function getChildName() public view returns (string memory) {
        return childName;
    }



    //多态1
    function test(uint v) public pure returns (uint) {
        return v;
    }

    //多态2
    function test(uint v,string memory name) public pure returns (uint,string memory) {
        return (v,name);
    }
    
}