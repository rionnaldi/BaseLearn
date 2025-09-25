// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

error TooManyShares(uint256 wouldHave);

contract EmployeeStorage {
    uint16 private shares; // <= 5000
    uint24 private salary; // 0..1_000_000
    uint256 public idNumber;
    string public name;

    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    function viewSalary() public view returns (uint24) {
        return salary;
    }
    function viewShares() public view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) public {
        if (_newShares > 5000) revert("Too many shares");
        uint256 wouldHave = uint256(shares) + uint256(_newShares);
        if (wouldHave > 5000) revert TooManyShares(wouldHave);
        shares = uint16(wouldHave);
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }
    function debugResetShares() public {
        shares = 1000;
    }
}
