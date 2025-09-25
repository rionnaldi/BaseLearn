// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract FavoriteRecords {
    // Custom error for non-approved records
    error NotApproved(string albumName);

    // Public mapping to check if records are approved
    mapping(string => bool) public approvedRecords;

    // Mapping from user address to their favorite records
    mapping(address => mapping(string => bool)) public userFavorites;

    // Array to keep track of approved record names for retrieval
    string[] private approvedRecordsList;

    // Array to keep track of user favorites for retrieval
    mapping(address => string[]) private userFavoritesList;

    constructor() {
        // Load approved records
        string[9] memory records = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];

        for (uint i = 0; i < records.length; i++) {
            approvedRecords[records[i]] = true;
            approvedRecordsList.push(records[i]);
        }
    }

    // Get all approved records
    function getApprovedRecords() public view returns (string[] memory) {
        return approvedRecordsList;
    }

    // Add record to user's favorites if approved
    function addRecord(string memory _albumName) public {
        if (!approvedRecords[_albumName]) {
            revert NotApproved(_albumName);
        }

        // Only add if not already in favorites
        if (!userFavorites[msg.sender][_albumName]) {
            userFavorites[msg.sender][_albumName] = true;
            userFavoritesList[msg.sender].push(_albumName);
        }
    }

    // Get user's favorite records
    function getUserFavorites(
        address _user
    ) public view returns (string[] memory) {
        return userFavoritesList[_user];
    }

    // Reset caller's favorites
    function resetUserFavorites() public {
        // Remove all favorites from the mapping
        string[] memory currentFavorites = userFavoritesList[msg.sender];
        for (uint i = 0; i < currentFavorites.length; i++) {
            userFavorites[msg.sender][currentFavorites[i]] = false;
        }

        // Clear the array
        delete userFavoritesList[msg.sender];
    }
}
