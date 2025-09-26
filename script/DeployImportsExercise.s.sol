// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ImportsExercise} from "../src/ImportsExercise.sol";

contract DeployImportsExercise is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the ImportsExercise contract
        ImportsExercise importsExercise = new ImportsExercise();

        vm.stopBroadcast();

        // Log the deployed address
        console.log("ImportsExercise deployed at:", address(importsExercise));
    }
}
