// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract BasicMath {
    uint256 a;
    uint256 b;

    function adder(
        uint256 _a,
        uint256 _b
    ) external pure returns (uint256 sum, bool error) {
        unchecked {
            sum = _a + _b;
            if (sum < _a) {
                // Overflow occurred
                return (0, true);
            }
            return (sum, false);
        }
    }

    function subtractor(
        uint256 _a,
        uint256 _b
    ) external pure returns (uint256 difference, bool error) {
        if (_b > _a) {
            // Underflow would occur
            return (0, true);
        }
        return (_a - _b, false);
    }
}
