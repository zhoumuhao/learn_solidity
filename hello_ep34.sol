// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

enum State {
    Pending,  //交易执行中
    Approved, //交易已同意
    Rejected  //交易已拒绝
}

//签名者信息
struct Signer {
    address account;  //签名人
    State  state; //签名状态
    uint  signedAt;  //签名时间
}

library SignerArray {

    function find(Signer[] storage _signer, address addr) internal view returns (int) {
        for (uint i;i<_signer.length;i++) {
            if(_signer[i].account == addr) {
                return int(i);
            }
        }
        return -1;
    }
    
}

/*
**  多签钱包
*/
contract MultiSignEp34 {

    //引入类库
    using SignerArray for Signer[];

    //交易信息
    struct Transaction {
        uint id;
        string title;  //转账标题
        uint value; //eth值
        bytes data; //是否执行合约
        // Signer[] signer; //签名者
        State state; //状态
        uint[3] timeAt; //ApprovedAt  rejectedAt createdAt
        address to; //往哪个账号转钱
    }

    //共管者信息
    address[] owner;

    Transaction[] transaction;

    uint public txId;

    mapping (uint=>Signer[]) public transactionSigner;

    //事件
    event Commited(uint indexed txId,address indexed creator,string title,uint timeAt);
    event Approved(uint indexed txId,address indexed signer,uint timeAt);
    event Rejected(uint indexed txId,address indexed signer,uint timeAt);

    //修改器
    modifier checkBefore(uint _txId) {
        require(_txId>0 && _txId<=txId, "Trx dose not exist");
        require(transaction[_txId - 1].state==State.Pending, "Trx was finished");
        require(transactionSigner[txId].find(msg.sender)== -1, "Trx was signed");
        _;
    }
    
    //提交交易
    function commit(string memory title,address to,uint value,bytes calldata data) external {
        Transaction memory trx;
        trx.id = ++ txId;
        trx.title = title;
        trx.value = value;
        trx.to = to;
        trx.data = data;
        trx.state = State.Pending;
        trx.timeAt[2] = block.timestamp;
        transaction.push(trx);
        
        transactionSigner[txId].push(Signer({
            account:msg.sender,
            state:State.Approved,
            signedAt:block.timestamp
        }));
        //触发交易事件
        emit Commited(txId, msg.sender, title,block.timestamp);
    }

    //同意
    function approved(uint _txId) external checkBefore(_txId){
         transactionSigner[txId].push(Signer({
            account:msg.sender,
            state:State.Approved,
            signedAt:block.timestamp
        }));
        //所有人均同意
        if(transactionSigner[_txId].length==owner.length) {
            transaction[_txId-1].state = State.Approved;   
            transaction[_txId-1].timeAt[0] = block.timestamp;  
            (bool ok,) = address(transaction[_txId-1].to).call{value:transaction[_txId-1].value}(transaction[_txId-1].data);
            require(ok, "Exceute fail");
        }
        //触发同意事件
        emit Approved(_txId, msg.sender, block.timestamp);
    }

    //拒绝
    function rejected(uint _txId) external checkBefore(_txId){

         transaction[_txId-1].state = State.Rejected;
         transaction[_txId-1].timeAt[1] = block.timestamp;

         transactionSigner[txId].push(Signer({
            account:msg.sender,
            state:State.Rejected,
            signedAt:block.timestamp
        }));
        emit Rejected(_txId, msg.sender, block.timestamp);  
    }


    
}