// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Executor {

    string public gender; 
    string public name;   //槽

    /*
    *设置名
    **/
    function setName(string memory _name) external {
        name = string(abi.encodePacked("Executor->",_name));
    }

}

/**
**委托回调
*/
contract delegateFun {

    string public gender;
    string public name;

    

    function makeExecor() external returns (Executor ){
        return new Executor();
    }
    //TODO::设置本合约内属性  Executor  相当于他的槽位  属性必须一一对应
    function setName( address addr,string memory _name) external returns (bool,bytes memory) {
        return addr.delegatecall(abi.encodeWithSignature("setName(string)", _name));
    }
    
}