// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {ArraysExercise} from "../src/ArraysExercise.sol";
import {Script} from "forge-std/Script.sol";

contract DeployArraysExercise is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new ArraysExercise();
        vm.stopBroadcast();
    }
}
