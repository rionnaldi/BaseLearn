// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./SillyStringUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;

    // Public instance of Haiku
    SillyStringUtils.Haiku public haiku;

    // Save three strings as haiku lines
    function saveHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) public {
        haiku = SillyStringUtils.Haiku({
            line1: _line1,
            line2: _line2,
            line3: _line3
        });
    }

    // Get the complete haiku as a Haiku type
    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    // Return a modified haiku with shruggie added to line3 (without modifying original)
    function shruggieHaiku()
        public
        view
        returns (SillyStringUtils.Haiku memory)
    {
        return
            SillyStringUtils.Haiku({
                line1: haiku.line1,
                line2: haiku.line2,
                line3: SillyStringUtils.shruggie(haiku.line3)
            });
    }
}
