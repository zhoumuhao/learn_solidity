// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//延升
interface proxy {
    function setName(string memory _name)  external  payable ;

    function getName() external returns (string memory);

    function getBalance()external view returns (uint);

    function throwErro() external pure;
}

/*
*定义一个user类
*/
contract User {
     string name;

     function setName(string memory _name)  external  payable {
        name = _name;
     }

     function getName() public view returns (string memory) {
        return name;
     }
     fallback() external payable { }
     receive() external payable { }
     
     //获取自己的余额
     function getBalance()external view returns (uint) {
        return address(this).balance;
     }
    
    //抛出错误
     function throwErro() external pure {
        revert("throw error");
     }
}
/*
**低级call
* address.call{gas:100,value:0}()  写入
* address.staticcall()     读写
*/
contract Ep26 {

    address public addr;

     fallback() external payable { }
     receive() external payable { }

    //创建一个实例
    function makeUser() external returns(address) {
         return addr = address(new User());
    }
    //设置
    function callSetName(string memory _name) external payable {
        (bool ok, ) = addr.call{value:1 ether}(abi.encodeCall(User.setName, (_name)));
        require(ok, "Call set name");
    }
    //获取
    function callGetName() external view returns (string memory){
        (bool ok,bytes memory result) = addr.staticcall(abi.encodeCall(User.getName,()));
        require(ok,"call get name failed");
        return abi.decode(result, (string));
    }

     //获取余额
    function callGetBalance() external view returns (uint){
        (bool ok,bytes memory result) = addr.staticcall(abi.encodeCall(User.getBalance,()));
        require(ok,"call get balance failed");
        return abi.decode(result, (uint));
    }

     //获取异常
    function callGetThrow() external view returns (string memory){
        (bool ok,bytes memory result) = addr.staticcall(abi.encodeCall(User.throwErro,()));
        if(!ok) {
            assembly {
                result :=add(result,4)
            }
        }
        return abi.decode(result, (string));
    }

     //设置
    function proxySetName(string memory _name) external payable {
        proxy(addr).setName(_name);
    }
    //获取
    function proxyGetName() external  returns (string memory){
        return proxy(addr).getName();
    }

     //获取余额
    function proxyGetBalance() external view returns (uint){
        return proxy(addr).getBalance();
    }

    //抛出异常
    function proxyErro() external view returns (string memory){
        try proxy(addr).throwErro(){
            return "nil";
        }catch Error(string memory reason) {
            return string(abi.encodePacked("try-catch",reason));
        }
    }
    
}