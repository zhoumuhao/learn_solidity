// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*数组
*/
contract HelloEp9 {
    uint[]list;

    //增加数组
    function push(uint a) public returns (uint[] memory) {
        list.push(a);
        return list;
    }

    //获取数组的长度
    function len() public view returns (uint){
        return list.length;
    }

    //查找第一个值所在的索引数
    function findIndexFirst(uint v) public view returns (int) {
        for (uint i;i<list.length;i++) {
            if(list[i]==v) return int(i) /*强制转换*/;
        }
        return -1;
    }

    //替换
    function replace(uint index,uint value) public returns (uint[] memory) {
        list[index] = value;
        return list;
    }

    //删除
    function remove(uint index) public returns (uint[] memory) {
        for (uint n; n<list.length; n++) 
        {
            if(n>=index) {
                list[n] = n+1>list.length?0:list[n+1];
            }
        }
        list.pop();
        return list;
    }

    //操作内存数组
    function arrMem(uint _len)public pure returns (uint[] memory) {
        uint[] memory v = new uint[](_len);
        return v;
    }

    //给内存数组赋值
    function arrMem1(uint _len,uint pv)public pure returns (uint[] memory) {
        uint[] memory v = new uint[](6);
        for (uint i; i<_len; i++) 
        {
            v[i]=pv;
        }
        return v;
    }

}