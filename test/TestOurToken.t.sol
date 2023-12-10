// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {ourToken} from "../src/ourToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OurTokenTest is StdCheats, Test {
    uint256 BOB_STARTING_AMOUNT = 100 ether;

    ourToken public OurToken;
    DeployOurToken public deployer;
    address public deployerAddress;
    address bob;
    address alice;

    function setUp() public {
        deployer = new DeployOurToken();
        OurToken = deployer.run();

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        deployerAddress = vm.addr(deployer.deployer_Key());
        vm.prank(deployerAddress);
        OurToken.transfer(bob, BOB_STARTING_AMOUNT);
    } 
        function testBalanceOfBob() public {
        assertEq(BOB_STARTING_AMOUNT, OurToken.balanceOf(bob));
    }

    function testInitialSupply() public {
        assertEq(OurToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }
   


    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(OurToken)).mint(address(this), 1);
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        OurToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(alice);
        OurToken.transferFrom(bob, alice, transferAmount);
        assertEq(OurToken.balanceOf(alice), transferAmount);
        assertEq(OurToken.balanceOf(bob), BOB_STARTING_AMOUNT - transferAmount);
    }
  

// function testTransferFrom() public {
//    uint256 amount = 100;
//    OurToken.approve(address(this), amount);
//    OurToken.transferFrom(address(this), address(deployer), amount);
//    assertEq(OurToken.balanceOf(address(this)), 0);
//    assertEq(OurToken.balanceOf(address(deployer)), amount);
// }
    function testTransferFrom() public {
   uint256 amount = 100;

   // Alice approves Bob to spend tokens on her behalf
   vm.prank(bob);
   OurToken.approve(alice, amount);

   // alice transfers tokens from Alice to the contract
   vm.prank(alice);
   OurToken.transferFrom(bob, address(this) , amount);

   assertEq(OurToken.balanceOf(bob), BOB_STARTING_AMOUNT - amount);
   assertEq(OurToken.balanceOf(address(this)), amount);
}

}
    // can you get the coverage up?
// contract OurTokenTest is Test {
//     ourToken public OurToken;
//     DeployOurToken deployer;

//     address bob = makeAddr("bob");
//     address alice = makeAddr("alice");

//     uint256 public constant STARTING_BALANCE = 100 ether;

//     function setUp() public {
//         deployer = new DeployOurToken();
//         OurToken = deployer.run();

//         vm.prank(msg.sender);
//         OurToken.transfer(bob,  STARTING_BALANCE);
//     }

