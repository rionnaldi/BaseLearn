// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./AddressBook.sol";

contract AddressBookFactory {
    // Deploy a new AddressBook instance with caller as owner
    function deploy() public returns (address) {
        // Use the 'new' keyword to create a new instance
        AddressBook newAddressBook = new AddressBook(msg.sender);

        // Return the address of the newly created contract
        return address(newAddressBook);
    }
}
