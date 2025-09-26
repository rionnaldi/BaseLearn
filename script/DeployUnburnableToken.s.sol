// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {UnburnableToken} from "../src/UnburnableToken.sol";

contract DeployUnburnableToken is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the UnburnableToken contract
        UnburnableToken unburnableToken = new UnburnableToken();

        vm.stopBroadcast();

        // Log the deployed address
        console.log("UnburnableToken deployed at:", address(unburnableToken));

        // Log contract details
        console.log("Total Supply:", unburnableToken.totalSupply());
        console.log("Total Claimed:", unburnableToken.totalClaimed());
        console.log("Contract is ready for token claims!");
        console.log("Users can claim 1000 tokens each (one time only)");
    }
}
