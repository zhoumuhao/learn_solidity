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


contract ERC20TokenEp32 is IERC20Metadata{

    string  _name;
    string  _symbol;
    uint8 _decimals;
    //总供应量
    uint256 _totalSupply;
    //余额
    mapping (address=>uint256) balance;
    mapping (address=> mapping (address => uint256)) approves;

    constructor(string memory _name_,string memory _symbol_,uint8 _decimals_,uint256 _totalSupply_) {
       _name =  _name_;
       _symbol = _symbol_;
       _decimals = _decimals_;
       _totalSupply = _totalSupply_;

       balance[msg.sender] = _totalSupply;
       emit Transfer(address(0), msg.sender, _totalSupply);

    }

     function name() external override  view returns (string memory) {
        return _name;
     }

    function symbol() external override  view returns(string memory) {
        return _symbol;
    }

    //小数点的精度
    function decimals() external override  view returns (uint8) {
        return _decimals;
    }

    //总供应量
    function totalSupply() external override view returns(uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external override  view returns (uint256) {
        return balance[account];
    }

     function transfer(address to,uint256 amount ) external override  returns (bool) {
       return _transfer(msg.sender,to,amount);
     }

     function allowance(address owner,address spender) external override  view returns (uint256) {
        return approves[owner][spender];
     }

     function approve(address spender,uint256 amount) external override  returns (bool) {
        require(approves[msg.sender][spender]==0, "Already Approved!");
        approves[msg.sender][spender] = amount;
        emit approval(msg.sender, spender, amount);
        return true;
     }


     function transferFrom(address from,address to,uint256 amount) external override  returns (bool) {
        require(approves[from][msg.sender]>=amount, "No approve!");
        approves[from][msg.sender] -= amount;
        return _transfer(from,to,amount);

     }

     // 转账
     function _transfer(address from,address to,uint256 amount) internal returns (bool) {
        require(balance[from]>=amount, "Insufficient balance!");
        balance[to] += amount;
        balance[from] -= amount;
        emit Transfer(from, to, amount);
        return true;
     }
    

}