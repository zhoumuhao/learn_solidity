// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
** 数据位置
*  storage    存储在合约中  永久保存
*  memory     存储在内存中  
*  calldata   与 memory 差不多；但是有切片的属性;数组切片走0 开始
*/
contract HelloEp21 {
    
    string name = "location";

    function mock(string memory v,uint[] calldata arr) external view returns(
        string memory,
        string memory,
        uint[] calldata,
        bytes4) {
        //定义storage  应用地址
        string storage _name = name;
        return (_name,v,arr[1:3],bytes4(msg.data[:4]));
    }
}