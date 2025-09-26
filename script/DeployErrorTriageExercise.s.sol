// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ErrorTriageExercise} from "../src/ErrorTriageExercise.sol";

contract DeployErrorTriageExercise is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the ErrorTriageExercise contract
        ErrorTriageExercise errorTriageExercise = new ErrorTriageExercise();

        vm.stopBroadcast();

        // Log the deployed address
        console.log(
            "ErrorTriageExercise deployed at:",
            address(errorTriageExercise)
        );
    }
}
