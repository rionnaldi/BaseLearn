// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {BasicMath} from "../src/BasicMath.sol";
import {Script} from "forge-std/Script.sol";

contract DeployBasicMath is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new BasicMath();
        vm.stopBroadcast();
    }
}
