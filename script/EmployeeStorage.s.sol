// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {EmployeeStorage} from "../src/EmployeeStorage.sol";
import {Script} from "forge-std/Script.sol";

contract DeployStorageExercise is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new EmployeeStorage();
        vm.stopBroadcast();
    }
}
