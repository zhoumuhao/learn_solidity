// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract testFirst {

    string public name;

    function setName(string memory _name)external {
        name = _name;
    }
}

contract  testSecond {

    uint public gender;

    function setGender(uint _gender) external {
        gender = _gender;
    }

}

/*
* MultiCall
**/
contract MultiCallEp29 {

    address[2] public addr;

    event Log(address indexed  addr);

    function makeTestFirst() external {
        addr[0] = address(new testFirst());
    }

    function makeTestSecond() external {
        addr[1] = address(new testSecond());
    }
    

    //TODO::以下两种多态写法
    function makCallData(string memory fn,uint8  args) external pure returns (bytes memory ){
        return abi.encodeWithSignature(fn, args);
    }

    function makCallData(string memory fn,string memory args) external pure returns (bytes memory ){
        return abi.encodeWithSignature(fn, args);
    }


    function multiRead(bytes[2] memory _calllData) external view returns (
        string memory name,   //隐式变量 不需要return 不需要重新返回
        uint8 gender) {

        (bool ok,bytes memory  _result) = addr[0].staticcall(_calllData[0]);
        require(ok, "multi[0] read fail");
        name = abi.decode(_result, (string));

        ( ok, _result) = addr[1].staticcall(_calllData[1]);
        require(ok, "multi[1] read fail");
        gender = abi.decode(_result, (uint8));

    }

     function multiWrite(bytes[2] memory _calllData) external  {

        (bool ok,) = addr[0].call(_calllData[0]);
        require(ok, "multi[0] write fail");

        ( ok, ) = addr[1].call(_calllData[1]);
        require(ok, "multi[1] write fail");
    }

    
}