// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HaikuNFT is ERC721 {
    // Custom errors
    error HaikuNotUnique();
    error NotYourHaiku(uint256 id);
    error NoHaikusShared();

    // Haiku struct
    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    // Storage variables
    Haiku[] public haikus;
    mapping(address => uint256[]) public sharedHaikus;
    uint256 public counter = 1; // Start at 1, not 0

    // Track used lines to ensure uniqueness
    mapping(string => bool) private usedLines;

    constructor() ERC721("HaikuNFT", "HAIKU") {}

    // Mint a new Haiku NFT
    function mintHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external {
        // Check if any line has been used before
        if (usedLines[_line1] || usedLines[_line2] || usedLines[_line3]) {
            revert HaikuNotUnique();
        }

        // Mark lines as used
        usedLines[_line1] = true;
        usedLines[_line2] = true;
        usedLines[_line3] = true;

        // Create the haiku
        Haiku memory newHaiku = Haiku({
            author: msg.sender,
            line1: _line1,
            line2: _line2,
            line3: _line3
        });

        // Add haiku to array
        haikus.push(newHaiku);

        // Mint NFT with current counter as ID
        _mint(msg.sender, counter);

        // Increment counter for next mint
        counter++;
    }

    // Share a haiku with another address
    function shareHaiku(address _to, uint256 _id) public {
        // Check if sender owns the haiku NFT
        if (ownerOf(_id) != msg.sender) {
            revert NotYourHaiku(_id);
        }

        // Add haiku ID to the recipient's shared haikus
        sharedHaikus[_to].push(_id);
    }

    // Get all haikus shared with the caller
    function getMySharedHaikus() public view returns (Haiku[] memory) {
        uint256[] memory sharedIds = sharedHaikus[msg.sender];

        // Check if any haikus are shared with caller
        if (sharedIds.length == 0) {
            revert NoHaikusShared();
        }

        // Create array to store shared haikus
        Haiku[] memory sharedHaikusArray = new Haiku[](sharedIds.length);

        // Populate array with haikus
        for (uint256 i = 0; i < sharedIds.length; i++) {
            // Note: haikus array is 0-indexed, but NFT IDs start at 1
            sharedHaikusArray[i] = haikus[sharedIds[i] - 1];
        }

        return sharedHaikusArray;
    }
}
