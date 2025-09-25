// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

error AfterHours(uint256 time);

contract ControlStructures {
    function fizzBuzz(uint _number) external returns (string memory something) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }
    function doNotDisturb(uint _time) external returns (string memory status) {
        if (_time >= 2400) {
            assert(false);
        }
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }
        if (_time >= 800 && _time <= 1199) return "Morning!";
        if (_time >= 1300 && _time <= 1799) return "Afternoon!";
        if (_time >= 1800 && _time <= 2200) return "Evening!";
        revert("Invalid time");
    }
}
