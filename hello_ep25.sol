// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/**
**  ABI 是应用二进制接口，ABI是从区块链外部与合约进行交互以及合约与合约间进行交互的一种标准方式。数据会根据其类型进行编码。需要一种特定的概要（schema）来进行解码。
****/
contract AbiEp25 {

    //编码
    function encodeFun(uint a,string memory b) public pure returns (bytes memory) {
        return abi.encode(a,b);
    }

    /*
    *解码
    */
    function decodeFun(bytes memory v) public pure returns(uint,string memory) {
       (uint a,string memory b)  = abi.decode(v, (uint,string));
       return (a,b);
    }

    function encodeWithSginature() external pure returns(bytes memory){
        return abi.encodeWithSignature("test(uint,string)",1,"hello");
    }

    function encodeWithSelector() external pure returns(bytes memory){
        return abi.encodeWithSelector(bytes4(keccak256(bytes("test(uint,string)"))), 1,"hello");
        // selector中的参数为：(selector,arg1,arg2);
        // selector是bytes4类型的函数签名的前四个字节 可以通过使用bytes()将函数名及type转换为bytes数组
        // 再将结果使用keccak256()计算hash，然后再通过bytes4()将hash转换为bytes4类型的值
    }
    function test(uint a, string memory b) external pure returns(uint,string memory){
        return (a,b);
    }
    
}