// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Student {

    function  getName() external pure returns (string memory) {
        return "Student::getName()";
    }

    //自毁函数已弃用
    function kill() external {
        // selfdestruct(payable (tx.origin));
    }
}

/**
* create2部署合约
*  合约地址生成法
*  bytes memory packed = abi.encodePacked(
     uint8(0xff), //255
     address(this), 
     salt, //byte32
     keccak256(creationCode)  //bytes32
);
*  bytes32 hash = kecck256(packed);
*  address = new Address = address(uint160(uint(hash)))
*/
contract Create2ByCreationCodeEp31 {

    address public student;

    function killStudent() external {
        Student(student).kill();
        student = address(0);
    }

    function callStudentName() external view returns (string memory) {
        return Student(student).getName();
    }

    function makeStudent(string memory _salt) external returns(address) {
        return student = address(
            new Student{salt:keccak256(abi.encodePacked(_salt))}()
        );
    }

    //获取地址
    function getAddress(string memory _salt) external view returns (address) {
        return address(uint160(uint(
            keccak256(
                abi.encodePacked(
                    uint8(0xff),
                    address(this),
                    keccak256(abi.encodePacked(_salt)),
                    keccak256(type(Student).creationCode)
                )
            )
        )));
    }

    //create2
    function create2Student(string memory _salt) external returns(address tokenAddr) {
        bytes memory creationCode = getCreationCode();
        bytes32 _salt_hash = keccak256(abi.encodePacked(_salt));
        assembly{
            tokenAddr:=create2(
                0, /*eth wei*/
                add(creationCode,32),
                mload(creationCode),
                _salt_hash
            )
            if iszero(extcodesize(tokenAddr)) {
                revert(0,0)
            }
            sstore(student.slot,tokenAddr)
        }

    }


    function getCreationCode() public  pure returns (bytes memory) {
        return type(Student).creationCode;
    }



    
}