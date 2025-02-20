// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*类库的使用
*/

//定义一个类库
library Math {

    //库合约函数的可视范围通常为 internal，可变性为 pure，也就是对所有使用它的合约可见。
    //定义成 external 毫无意义，因为库合约函数只在内部使用，不独立运行。
    //同样定义成 private 也不行，因为其它合约无法使用。
    function add(uint a,uint b) internal pure returns (uint){
        if(a<=2) {
            revert("a must less than 2");
        }
        return a+b;
    }

}

/*
**using for 更符合语义化;库合约使用 using for 比直接使用更省 gas
*/
contract HelloEp16 {
     // using for 可以让所有 uint数据，都具有 Math 内的方法 sum1
     using Math for uint;

    //第一种调用方法  直接调用
    function sum(uint _a) public pure returns (uint) {
        return Math.add(_a, 5);
    }

    //引入类库
    function sum1(uint _a) public pure returns (uint) {
        return _a.add(8);
    }
    
    
}
