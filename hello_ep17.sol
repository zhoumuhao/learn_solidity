// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
**可见性
* public   公开的
* private  私有的  不可继承
* external  不能作用于状态，只能作用于方法
* internal  私密性较好，可作用于 状态；外部不能调用  内部可继承使用
*/

contract HelloEp171 {

   uint private parentId =1;

   string internal parentName = "parent:name";

    //获取父级id
   function getParentId() external view returns (uint) {
     return parentId;
   }

    
}

contract HelloEp172 is HelloEp171{

    //获取父级名字
    function getParentName() internal    view returns (string memory) {
        return parentName;
    }
    
}


contract HelloEp173 {
   HelloEp172 ep =  new HelloEp172();
    //internal  外部不能直接调用
    // string m = ep.getParentName();
}