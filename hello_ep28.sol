// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*签名验证
*    step 1  内容进行 hash 加密   keccak() bytes32
*    step 2  通过当前账户 对 step1的结果 （含有以太坊前缀字符串）签名
*    step 3  通过（含有签名的字符串） ETH 哈希 + 签名结果  还原 签名 账户 address
*    step 4  验证签名  原始内容 + 签名结果 + 账户 address 校验 签名是否为 address 参数
*
*
**   前端
*    ethereum.enable()
*    ethereum.request({"methed":"personal_sign",param:[hash,accout]}).then(_sig=>{})
**/
contract HelloEp29 {

    //加密
    function msgHash(string memory _msg) public pure returns (bytes32) {
        return keccak256(bytes(_msg));
    }

    //签名
    function signedHash(bytes32 _hash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethreum Signed Message:\n32",_hash));
    }

    //一种在Solidity 中实现的预编译合约
    function recoverSigner(bytes32 _ethHash,bytes calldata _sig) public pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;
        
         r = bytes32(_sig[:32]);
         s = bytes32(_sig[32:64]);
         v = uint8(bytes1(_sig[64:]));
        return ecrecover(_ethHash, v, r, s);
    }

    //验证
    function verify(string memory _msg,bytes calldata _sig,address signer) public pure returns (bool) {
        return recoverSigner(signedHash(msgHash(_msg)), _sig)==signer;
    }

}