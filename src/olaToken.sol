
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;


contract olaToken {

    mapping ( address => uint) private _balances;

    function name() public pure returns (string memory ){
        return ("ola TOKEN");
    }
    function decimals() public pure returns (uint8){
        return 18;
    }
    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }
    
    function balanceOf(address _owner) public view returns (uint256) {
        return _balances[_owner];
    }
    function transfer(address _to, uint256 _amount) public{
        uint previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        _balances[msg.sender] -= _amount;
        _balances[_to] += _amount;
        require (balanceOf(msg.sender) + balanceOf(_to) == previousBalances);

    }



}