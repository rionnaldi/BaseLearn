// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {WeightedVoting} from "../src/WeightedVoting.sol";

contract DeployWeightedVoting is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the WeightedVoting contract
        WeightedVoting weightedVoting = new WeightedVoting();

        vm.stopBroadcast();

        // Log the deployed address
        console.log("WeightedVoting deployed at:", address(weightedVoting));

        // Log some useful information
        console.log("Token name:", weightedVoting.name());
        console.log("Token symbol:", weightedVoting.symbol());
        console.log("Max supply:", weightedVoting.maxSupply());
        console.log("Contract is ready for token claims and voting!");
    }
}
