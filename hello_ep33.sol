// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
*ERC20合约
*/
interface IERC20Metadata {

    function name() external view returns (string memory);

    function symbol() external view returns(string memory);

    //小数点的精度
    function decimals() external view returns (uint8);

    //总供应量
    function totalSupply() external view returns(uint256);

    //余额
    function balanceOf(address account) external view returns (uint256);

    //转出
    function transfer(address to,uint256 amount ) external returns (bool);

    //查询授权额度
    function allowance(address owner,address spender) external view returns (uint256);

    //授权
    function approve(address spender,uint256 amount) external returns (bool);

    //A 授权 B 10000 token   B transferFrom（A,C,100）
    function transferFrom(address from,address to,uint256 amount) external returns (bool);

    event Transfer(address indexed from,address indexed to,uint256 value);

    event approval(address indexed owner,address indexed spender,uint256 value);

}

/*
**时间锁合约
**/
contract TimeLockEp33 {

    event Locked(address indexed tokenAddr,address indexed tokenOwner,uint amount,uint expireAt);

    event WithDrawed(address indexed tokenAddr,address indexed tokenOwner,uint amount,uint timeAt);

    //tokenAddr=>tokenOwner=>[amount=>expire]
    mapping (address=>mapping (address=>uint[2])) lockAttr;

    /*
    *锁仓
    */
    function lock(address tokenAddr,uint amount,uint expireAt) external {
        require(expireAt>block.timestamp && expireAt>=lockAttr[tokenAddr][msg.sender][1], "lock is invaild");
        //转账
        bool ok = IERC20Metadata(tokenAddr).transferFrom(msg.sender,address(this),amount);
        require(ok, "transferFrom fail");

        lockAttr[tokenAddr][msg.sender][0] += amount;
        lockAttr[tokenAddr][msg.sender][1]  = expireAt>lockAttr[tokenAddr][msg.sender][1]?expireAt:lockAttr[tokenAddr][msg.sender][1];
        //加入事件
        emit Locked(tokenAddr, msg.sender, amount, expireAt);
    }

    //获取过期时间
    function getExpire(address tokenAddr,address tokenOwner) external view returns(uint) {
        return  lockAttr[tokenAddr][tokenOwner][1]>block.timestamp ? lockAttr[tokenAddr][msg.sender][1] :0;
    }

    //获取锁仓金额
    function getAmount(address tokenAddr,address tokenOwner) external view returns(uint) {
        return  lockAttr[tokenAddr][tokenOwner][0];
    }

    //提现
    function withDraw(address tokenAddr) external {
        require(lockAttr[tokenAddr][msg.sender][0]>0, "out of token");
        require(lockAttr[tokenAddr][msg.sender][1]<=block.timestamp, "Not expire");
        uint amount = lockAttr[tokenAddr][msg.sender][0];
        //转账
        IERC20Metadata(tokenAddr).transfer(msg.sender,amount);
        lockAttr[tokenAddr][msg.sender][0] = 0;
        emit WithDrawed(tokenAddr,msg.sender,amount,block.timestamp);
    }




}