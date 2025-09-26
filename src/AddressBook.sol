// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    // Custom error for contact not found
    error ContactNotFound(uint256 id);

    // Contact struct
    struct Contact {
        uint256 id;
        string firstName;
        string lastName;
        uint256[] phoneNumbers;
    }

    // Storage for contacts
    Contact[] private contacts;

    // Mapping to track which IDs exist for efficient lookup
    mapping(uint256 => bool) private contactExists;
    mapping(uint256 => uint256) private idToIndex; // Maps ID to array index

    // Counter for unique IDs
    uint256 private nextId = 1;

    constructor(address _owner) Ownable(_owner) {}

    // Add contact function - only owner
    function addContact(
        string memory _firstName,
        string memory _lastName,
        uint256[] memory _phoneNumbers
    ) public onlyOwner {
        uint256 contactId = nextId++;

        Contact memory newContact = Contact({
            id: contactId,
            firstName: _firstName,
            lastName: _lastName,
            phoneNumbers: _phoneNumbers
        });

        contacts.push(newContact);
        contactExists[contactId] = true;
        idToIndex[contactId] = contacts.length - 1;
    }

    // Delete contact function - only owner
    function deleteContact(uint256 _id) public onlyOwner {
        if (!contactExists[_id]) {
            revert ContactNotFound(_id);
        }

        uint256 indexToDelete = idToIndex[_id];
        uint256 lastIndex = contacts.length - 1;

        // Move the last contact to the position of the contact to delete
        if (indexToDelete != lastIndex) {
            Contact storage lastContact = contacts[lastIndex];
            contacts[indexToDelete] = lastContact;
            idToIndex[lastContact.id] = indexToDelete;
        }

        // Remove the last element
        contacts.pop();

        // Clean up mappings
        delete contactExists[_id];
        delete idToIndex[_id];
    }

    // Get contact function - public view
    function getContact(uint256 _id) public view returns (Contact memory) {
        if (!contactExists[_id]) {
            revert ContactNotFound(_id);
        }

        uint256 index = idToIndex[_id];
        return contacts[index];
    }

    // Get all contacts function - public view
    function getAllContacts() public view returns (Contact[] memory) {
        return contacts;
    }
}
