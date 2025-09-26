// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {GarageManager} from "../src/GarageManager.sol";
import {Script} from "forge-std/Script.sol";

contract DeployGarageManager is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new GarageManager();
        vm.stopBroadcast();
    }
}
