// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {HaikuNFT} from "../src/HaikuNFT.sol";

contract DeployHaikuNFT is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the HaikuNFT contract
        HaikuNFT haikuNFT = new HaikuNFT();

        vm.stopBroadcast();

        // Log the deployed address
        console.log("HaikuNFT deployed at:", address(haikuNFT));

        // Log contract details
        console.log("NFT name:", haikuNFT.name());
        console.log("NFT symbol:", haikuNFT.symbol());
        console.log("Current counter (next ID):", haikuNFT.counter());
        console.log("Contract is ready for haiku minting!");
        console.log("Users can mint unique haikus as NFTs");
        console.log("Haiku owners can share their haikus with others");
    }
}
