// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*接口与继承
*/

//申明一个接口
//external  修饰符表示函数只能被其他合约调用，不能在当前合约内部直接调用，不能用于修饰变量，只能修饰函数。外部函数通常用于提供合约的接口，可以从其他合约或外部交易调用。
interface User {

    //定义一个函数
    function runWork() external returns (bool);
    
}

//实现该函数  is 为实现
 contract ParentEp13 is User{
    //实现函数
    function runWork() public pure returns (bool){
        return true;
    }

    //internal修饰符表示函数或状态变量可以在当前合约内部以及继承合约中进行访问。与私有修饰符不同，internal修饰符允许继承的合约访问被修饰的函数或状态变量。对于需要在合约继承链中共享的内部逻辑，使用internal修饰符是有用的。
    function stopWork()   internal pure  returns (bool) {
        return false;
    }

    function test() public pure returns(string memory) {
        return "parent";
    }

    //TODO::测试可以在当前函数调用
    function test1() external pure returns(string memory) {
        return "not local use";
    }
    
    //TODO::测试无效
    function test2() public returns(string memory){
        return this.test1();
    }

    
 }

 //继承上面的函数
 contract HelloEp13 is ParentEp13 {

    //调用上级方法
   function getStopWork() public pure returns (bool) {
        return stopWork();
   }


   function concatSuper() public pure returns (string memory) {
    return string(bytes.concat("child",bytes(test())));
   }


 }