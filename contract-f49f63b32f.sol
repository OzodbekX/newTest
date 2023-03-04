// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.1/token/ERC20/ERC20.sol";
interface ERC20Interface{
    function totalSupply() external view returns(uint);
    function balanceOf(address account) external view returns (uint balance);
    function allowance(address owner, address spender) external view returns (uint remaining);
    function transfer(address receipent,uint amount) external returns (bool success);
    function approve(address spender,uint amount) external returns (bool success);
    function transferFrom(address sender,address receipent,uint amount) external returns (bool success);
    event Transfer(address indexed from,address indexed to, uint value);
    event Approval(address indexed owner,address indexed spender, uint value);
}
contract TestSolana is ERC20Interface {
    string public symbol;
    string public name;
    uint8 public decimals;
    uint public _totalSupply;
    mapping(address=>uint) balances;
    mapping(address=>mapping(address=>uint)) allowed;


    constructor() {
       symbol="ONX";
       name="NewTest Coin";
       decimals =18;
       _totalSupply=1_000_001_000_000_000_000_000;
       balances[0xF9bDDCe3C4D1C77FD7d9eB4705F12418353049d6]=_totalSupply;
       emit Transfer(address(0),0xF9bDDCe3C4D1C77FD7d9eB4705F12418353049d6,_totalSupply);
    }
    function totalSupply() public view returns (uint ){
        return _totalSupply-balances[address(0)];
    }
    function balanceOf(address account) public view returns(uint balance){
        return balances[account];
    }
    function transfer(address receipent,uint amount) public returns(bool success){
        balances[msg.sender]=balances[msg.sender]-amount;
        balances[receipent]=balances[receipent]+amount;
        emit Transfer(msg.sender,receipent,amount);
        return true;
    }
    function approve(address spender,uint amount)public returns(bool success){
        allowed[msg.sender][spender]=amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    function transferFrom(address sender,address receipent,uint amount)public returns(bool success){
        balances[sender]=balances[sender]-amount;
        allowed[sender][msg.sender]=allowed[sender][msg.sender]-amount;
        balances[receipent]=balances[receipent]+amount;
        emit Transfer(sender,receipent,amount);
        return true;
    }
    function allowance(address owner,address spender)public view returns(uint remaining){
        return allowed[owner][spender];
    }

}
