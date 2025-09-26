// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GarageManager {
    error BadCarIndex(uint256 carIndex);

    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    mapping(address => Car[]) public garage;

    function addCar(
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        garage[msg.sender].push(
            Car({
                make: _make,
                model: _model,
                color: _color,
                numberOfDoors: _numberOfDoors
            })
        );
    }

    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    function updateCar(
        uint256 _index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        Car[] storage cars = garage[msg.sender];
        if (_index >= cars.length) {
            revert BadCarIndex(_index);
        }
        cars[_index] = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
    }

    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}
