// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Salesperson, EngineeringManager, InheritanceSubmission} from "../src/InheritanceExercise.sol";

contract DeployInheritance is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy Salesperson with specified values:
        // - Hourly rate: 20 dollars an hour
        // - Id number: 55555
        // - Manager Id: 12345
        Salesperson salesperson = new Salesperson(55555, 12345, 20);

        // Deploy EngineeringManager with specified values:
        // - Annual salary: 200,000
        // - Id number: 54321
        // - Manager Id: 11111
        EngineeringManager engineeringManager = new EngineeringManager(
            54321,
            11111,
            200000
        );

        // Deploy InheritanceSubmission with the addresses
        InheritanceSubmission submission = new InheritanceSubmission(
            address(salesperson),
            address(engineeringManager)
        );

        vm.stopBroadcast();

        // Log the deployed addresses
        console.log("Salesperson deployed at:", address(salesperson));
        console.log(
            "EngineeringManager deployed at:",
            address(engineeringManager)
        );
        console.log("InheritanceSubmission deployed at:", address(submission));
    }
}
