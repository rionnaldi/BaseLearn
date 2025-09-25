// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {ControlStructures} from "../src/ControlStructures.sol";
import {Script} from "forge-std/Script.sol";

contract DeployControlStructures is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new ControlStructures();
        vm.stopBroadcast();
    }
}
