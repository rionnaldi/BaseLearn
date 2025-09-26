// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Abstract Employee contract
abstract contract Employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    // Virtual function to be overridden
    function getAnnualCost() public view virtual returns (uint);
}

// Salaried employee contract
contract Salaried is Employee {
    uint public annualSalary;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint _annualSalary
    ) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    // Override getAnnualCost to return annual salary
    function getAnnualCost() public view override returns (uint) {
        return annualSalary;
    }
}

// Hourly employee contract
contract Hourly is Employee {
    uint public hourlyRate;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint _hourlyRate
    ) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    // Override getAnnualCost to return hourly rate * 2080 hours
    function getAnnualCost() public view override returns (uint) {
        return hourlyRate * 2080;
    }
}

// Manager contract with employee management functionality
contract Manager {
    uint[] public employeeIds;

    // Add an employee ID to the reports array
    function addReport(uint _employeeId) public {
        employeeIds.push(_employeeId);
    }

    // Reset the reports array to empty
    function resetReports() public {
        delete employeeIds;
    }
}

// Salesperson inherits from Hourly
contract Salesperson is Hourly {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint _hourlyRate
    ) Hourly(_idNumber, _managerId, _hourlyRate) {}
}

// EngineeringManager inherits from both Salaried and Manager
contract EngineeringManager is Salaried, Manager {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint _annualSalary
    ) Salaried(_idNumber, _managerId, _annualSalary) {}
}

// Inheritance submission contract
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
