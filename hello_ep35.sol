// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// 搜索 众筹 address 索引位置
library addressArray {
   //发现
   function find(address[] memory addr,address search) internal pure returns (int) {
        for(uint n;n<addr.length;n++) {
            if(addr[n]==search) return int(n);
        }
        return -1;
   }
}

/*
*
* solidity   web3合约交互
*
*
* 众筹合约 Vue3 + Web3.js  智能合约交互
*
*
*
*
**/
contract Web3InteractEp35 {

    using addressArray for address[];

    //活动状态
    enum State {
        Pending,
        Success,
        Fail
    }
    /*
    * 定义活动的结构体
    **/
    struct Activity {
        uint256 id;//活动id
        address creator;  //活动发起者
        string title; //活动标题
        string description;   //活动描述
        uint deadline ;//截止时间
        uint value;  //筹款金额   单位 wei
        uint minValue; //筹款最小值
        uint minValuePercent; //完成后的比例
        uint createAt; //创建时间
        uint finishedTime; //完成时间
        // uint failedTime; //失败时间
        State state;
        uint receiveAmount;  //众筹实际金额
    }
  
    Activity[] public activity;   //活动信息

    uint public activityId;
    mapping (uint => address[]) public activitySender;
    mapping (uint=>mapping(address=>uint)) activitySendValue;  //activityId=>sender=>value

    //定义支付事件
    event pay(uint activityId,address sender,uint value,uint timeAt);

    //验证表格参数
    modifier checkForm(uint value,uint deadline,uint minValue,uint minValuePercent){
        require(value>0, "must greator than zero");
        require(deadline>(block.timestamp+15), "deadline is invalid"); //pow 出块约15s
        require(minValue>0,"must greator than zero");   //筹款最小值
        require(minValuePercent>=50, "min Value Percent is invalid");//活动的有效时间不能超过15s
        _;
    } 
    
    receive() external payable {}
    fallback() external payable {}

    //创建众筹活动
    function createActivity(
        string[2] memory attr,  //[title,desc]
        uint value,
        uint deadline,
        uint minValue,
        uint minValuePercent
    ) external checkForm(value,deadline,minValue,minValuePercent){
        Activity memory _activity;
        _activity.id = ++activityId;
        _activity.title=attr[0];
        _activity.description=attr[1];
        _activity.deadline = deadline;//截止时间
        _activity.value =  value ;   //筹款金额   单位 wei
        _activity.minValue =  minValue;   //筹款金额   单位 wei
        _activity.minValuePercent  = minValuePercent;
        _activity.createAt = block.timestamp;
        _activity.creator = msg.sender;
        _activity.state = State.Pending;
        activity.push(_activity);
    }

    //众筹付钱
    function payActivity(uint _activityId) external payable {
        require(_activityId<=activityId, "activity id is invaild");
        require(activity[_activityId-1].state==State.Pending,"the activity is finished");
        require(msg.value>=activity[_activityId-1].minValue,"min value is invaild");
        require(activity[_activityId-1].deadline>block.timestamp,"deadline is invaild");
        //赋值
        activity[_activityId-1].receiveAmount += msg.value;
        activitySendValue[_activityId][msg.sender] = msg.value;
        if( activitySender[_activityId].find(msg.sender)==-1) {
            activitySender[_activityId].push(msg.sender);
        }
        emit pay(_activityId, msg.sender, msg.value, block.timestamp);
    }

    //完成
    function finish(uint _activityId) external {
        require(_activityId<=activityId,"activity id is invaild");
        require(activity[_activityId-1].creator==msg.sender, "not activity creater");  //验证发起者
        require(activity[_activityId-1].state == State.Pending , "the activity is finished or fail ");//验证活动状态

        if(activity[_activityId-1].receiveAmount>=activity[_activityId-1].value) {
            //finsh
            uint value = activity[_activityId-1].receiveAmount;
            payable (activity[_activityId-1].creator).transfer(value);
            activity[_activityId-1].state = State.Success;
            activity[_activityId-1].finishedTime = block.timestamp;
        } else {
            //fail
            if(block.timestamp>=activity[_activityId-1].deadline) {
                activity[_activityId-1].state = State.Fail;
                activity[_activityId-1].finishedTime = block.timestamp;
            }
        }
    }

    function getActivity(uint _activityId) external view returns(bool,Activity memory){
        Activity memory _activity;
        if(_activityId>activityId || _activityId==0) return (false,_activity);
        return (true,activity[_activityId-1]);
    }  
}