// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { DeployBeeToken } from "../script/BeeToken.s.sol";
import { BeeToken } from "../src/BeeToken.sol";

contract BeeTokenTest is Test {

    BeeToken public beeToken;
    DeployBeeToken public deployer;

    address arjun = makeAddr("arjun");
    address hrithik = makeAddr("hrithik");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployBeeToken();
        beeToken = deployer.run();

        // Transfer initial balance to Hrithik
        vm.prank(msg.sender);
        beeToken.transfer(hrithik, STARTING_BALANCE);
    }

    function testName() external view {
        assertEq("BeeToken", beeToken.name());
    }

    function testArjunBalance() public view {
        assertEq(STARTING_BALANCE, beeToken.balanceOf(hrithik));
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Hrithik approves Arjun to spend tokens on his behalf
        vm.prank(hrithik);
        beeToken.approve(arjun, initialAllowance);

        uint256 transferAmount = 500;

        // Arjun transfers tokens from Hrithik's account
        vm.prank(arjun);
        beeToken.transferFrom(hrithik, arjun, transferAmount);

        assertEq(beeToken.balanceOf(arjun), transferAmount);
        assertEq(beeToken.balanceOf(hrithik), STARTING_BALANCE - transferAmount);
    }

    // Test for decreasing allowances and allowance exhaustion
    function testAllowanceDecrease() public {
        uint256 initialAllowance = 1000;

        // Hrithik approves Arjun to spend tokens
        vm.prank(hrithik);
        beeToken.approve(arjun, initialAllowance);

        uint256 firstTransferAmount = 400;

        // Arjun transfers a part of the allowance
        vm.prank(arjun);
        beeToken.transferFrom(hrithik, arjun, firstTransferAmount);

        uint256 secondTransferAmount = 600;

        // Arjun tries to transfer remaining allowance
        vm.prank(arjun);
        beeToken.transferFrom(hrithik, arjun, secondTransferAmount);

        assertEq(beeToken.balanceOf(arjun), firstTransferAmount + secondTransferAmount);
        assertEq(beeToken.balanceOf(hrithik), STARTING_BALANCE - (firstTransferAmount + secondTransferAmount));
    }

    // Test allowance expiration or invalid access
    function testFailAllowanceExceeds() public {
        uint256 initialAllowance = 1000;

        // Hrithik approves Arjun
        vm.prank(hrithik);
        beeToken.approve(arjun, initialAllowance);

        uint256 transferAmount = 1500;

        // Arjun attempts to transfer more than allowed, should revert
        vm.prank(arjun);
        vm.expectRevert("ERC20: insufficient allowance");
        beeToken.transferFrom(hrithik, arjun, transferAmount);
    }

    // Test transfer failures (when balance is insufficient)
    function testFailTransferExceedsBalance() public {
        uint256 transferAmount = 1100 ether; // More than Hrithik's balance

        vm.prank(hrithik);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        beeToken.transfer(arjun, transferAmount);
    }

    // Test transfer when balance is exactly zero
    function testFailTransferZeroBalance() public {
        uint256 transferAmount = 500 ether; // Some positive amount

        // Arjun has zero balance initially
        vm.prank(arjun);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        beeToken.transfer(hrithik, transferAmount);
    }

    // Test setting allowance to zero
    function testFailAllowanceToZero() public {
        uint256 initialAllowance = 1000;

        vm.prank(hrithik);
        beeToken.approve(arjun, initialAllowance);

        // Setting allowance to zero
        vm.prank(hrithik);
        beeToken.approve(arjun, 0);

        // Arjun should not be able to transfer anymore
        vm.prank(arjun);
        vm.expectRevert("ERC20: insufficient allowance");
        beeToken.transferFrom(hrithik, arjun, 100);
    }
}
