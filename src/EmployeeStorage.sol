// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract EmployeeStorage {
    // Custom error for too many shares
    error TooManyShares(uint256 totalShares);

    // Storage variables optimized for packing
    // Slot 0: shares (uint16) + salary (uint24) = 40 bits total (fits in one slot)
    uint16 private shares; // Up to 65,535 shares (more than enough for 5000 limit)
    uint24 private salary; // Up to 16,777,215 (covers 0-1,000,000 salary range)

    // Slot 1: name (string) - dynamic storage
    string public name;

    // Slot 2: idNumber (uint256) - full slot needed for up to 2^256-1
    uint256 public idNumber;

    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    function viewSalary() public view returns (uint256) {
        return salary;
    }

    function viewShares() public view returns (uint256) {
        return shares;
    }

    function grantShares(uint256 _newShares) public {
        // Check if _newShares itself is greater than 5000
        if (_newShares > 5000) {
            revert("Too many shares");
        }

        // Calculate what the total would be
        uint256 newTotal = uint256(shares) + _newShares;

        // Check if this would result in more than 5000 total shares
        if (newTotal > 5000) {
            revert TooManyShares(newTotal);
        }

        // Add the shares if all checks pass
        shares = uint16(newTotal);
    }

    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\_(ツ)_/¯
     *
     * Fair warning though, if you do cheat, it will be on the blockchain having been
     * deployed by your wallet....FOREVER!
     */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    /**
     * Warning: Anyone can use this function at any time!
     */
    function debugResetShares() public {
        shares = 1000;
    }
}
