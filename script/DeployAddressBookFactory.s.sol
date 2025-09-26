// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {AddressBookFactory} from "../src/AddressBookFactory.sol";

contract DeployAddressBookFactory is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the AddressBookFactory contract
        AddressBookFactory factory = new AddressBookFactory();

        vm.stopBroadcast();

        // Log the deployed address
        console.log("AddressBookFactory deployed at:", address(factory));

        // Optional: Test the factory by creating an AddressBook
        console.log(
            "Factory is ready to deploy AddressBook instances via deploy() function"
        );
    }
}
