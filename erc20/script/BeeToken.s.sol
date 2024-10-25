// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import { BeeToken } from "../src/BeeToken.sol";

contract DeployBeeToken is Script {
    function run() external returns (BeeToken) {
        vm.startBroadcast();
        BeeToken beeToken = new BeeToken();
        vm.stopBroadcast();
        return beeToken;
    }
}