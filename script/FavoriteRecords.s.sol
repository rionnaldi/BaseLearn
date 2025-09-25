// SPDX-license-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {FavoriteRecords} from "../src/FavoriteRecords.sol";

contract DeployFavoriteRecords is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new FavoriteRecords();
        vm.stopBroadcast();
    }
}
