// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;
import {Script} from "../lib/forge-std/src/Script.sol";
import {ourToken} from "../src/ourToken.sol";
contract DeployOurToken is Script {
    uint public constant INITIAL_SUPPLY = 10000 ether;
    uint public constant anvil_Private_Key = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint public deployer_Key;
    function run () external returns(ourToken) {
        if (block.chainid == 31337) {
            deployer_Key = anvil_Private_Key;
        } else {
            deployer_Key = vm.envUint("private_key");
        }
        vm.startBroadcast(deployer_Key);
        ourToken OT = new ourToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return OT;
    }
   
}

