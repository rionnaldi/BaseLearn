// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ArraysExercise {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    address[] public senders;
    uint[] public timestamps;

    // Return the entire numbers array
    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    // Reset numbers to 1-10
    function resetNumbers() public {
        delete numbers;
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    // Append an array to numbers
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // Save sender and timestamp
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // Return timestamps and senders after Y2K
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }
        uint[] memory filteredTimestamps = new uint[](count);
        address[] memory filteredSenders = new address[](count);
        uint j = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                filteredTimestamps[j] = timestamps[i];
                filteredSenders[j] = senders[i];
                j++;
            }
        }
        return (filteredTimestamps, filteredSenders);
    }

    // Reset senders
    function resetSenders() public {
        delete senders;
    }

    // Reset timestamps
    function resetTimestamps() public {
        delete timestamps;
    }
}
