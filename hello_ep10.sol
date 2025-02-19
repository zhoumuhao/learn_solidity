// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*结构体
*/
contract HelloEp10 {

    /*
    *学生信息
    */
    struct Student {
        string name;
        uint8 gender;
        uint8 age;
        uint8 creatAd;
    }

    /*
    *学生列表
    */
    Student[] studentList;

    //函数构造器 检查学生列表是否符合规范
    modifier checkArrayOutOfBond(uint k) {
        require(k<studentList.length,"out of bonds");
        _;
    }

    //新增学生信息
    function addStudent(Student memory item) public returns (Student memory){
        studentList.push(item);
        return item;
    }

    //修改学生姓名
    function editStudentName(uint k,string memory _name) public checkArrayOutOfBond(k) returns(Student memory) {
        studentList[k].name = _name;
        return studentList[k];
    }

    //根据索引获取学生信息
    function getStudentByIndex(uint k) public checkArrayOutOfBond(k) view  returns(Student memory) {
        return studentList[k];
    } 

    //根据姓名获取学生信息
    function getStudentByName(string memory _name) public view returns(bool,Student memory) {
        Student memory holder;
        for (uint n; n<studentList.length; n++) 
        {
            if(keccak256(abi.encodePacked(studentList[n].name))==keccak256(abi.encodePacked(_name))){
                return (true,studentList[n]);
            }
        }
        return (false,holder);
    }

    //获取学生列表
    function getStudentList() public view returns (Student[] memory) {
        return studentList;
    }

    //根据索引删除某个学生
    function removeStudentByIndex(uint index) public returns (Student[] memory) {
        Student memory holder;

        for (uint i; i<studentList.length; i++) 
        {
            if(i>=index) {
                studentList[i] = (i+1)>studentList.length ? holder:studentList[i+1];
            }
        }
         studentList.pop();
         return studentList;
    }

}