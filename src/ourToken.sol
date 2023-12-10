// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ourToken is ERC20 {
    constructor (uint initialSupply) ERC20("ourToken", "OT") {
        _mint(msg.sender, initialSupply);

    }
    
}