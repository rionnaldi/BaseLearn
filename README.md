# BaseLearn - Solidity Learning Exercises 🎓

A collection of Solidity smart contracts implementing solutions to the [Base Learn](https://docs.base.org/learn/welcome/) exercises. This repository contains progressive learning exercises covering fundamental to advanced Solidity concepts.

## 📚 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Exercises & Contracts](#exercises--contracts)
- [Deployment Scripts](#deployment-scripts)
- [Development Workflow](#development-workflow)
- [Testing](#testing)
- [Contributing](#contributing)

## 🎯 Overview

This codebase contains solutions to Base's Solidity learning curriculum, covering:

- **Basic Math Operations** with overflow/underflow protection
- **Control Structures** and conditional logic
- **Storage Optimization** and variable packing
- **Arrays & Mappings** manipulation
- **Structs** and complex data types
- **Inheritance** patterns and abstract contracts
- **Import Systems** and library usage
- **Error Handling** and debugging techniques
- **Factory Patterns** with the `new` keyword
- **ERC-20 Tokens** with voting mechanisms
- **ERC-721 NFTs** with unique content validation
- **Custom Token** implementations

## ⚡ Prerequisites

- **Node.js** (v16 or higher)
- **Foundry** toolkit
- **Git**
- Basic understanding of Solidity and Ethereum

### Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd BaseLearn
   ```

2. **Install dependencies**
   ```bash
   forge install
   ```

3. **Build all contracts**
   ```bash
   forge build
   ```

4. **Run tests**
   ```bash
   forge test
   ```

5. **Deploy a contract** (example)
   ```bash
   forge script script/DeployBasicMath.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
   ```

## 📋 Exercises & Contracts

### 1. **BasicMath.sol** - Math Operations with Safety
```solidity
// Handles addition/subtraction with overflow/underflow detection
function adder(uint256 _a, uint256 _b) external returns (uint256 sum, bool error)
function subtractor(uint256 _a, uint256 _b) external returns (uint256 difference, bool error)
```
**Key Features:** Overflow protection, error flags, safe arithmetic

---

### 2. **EmployeeStorage.sol** - Storage Optimization
```solidity
// Optimized storage with variable packing
uint16 private shares;     // Packed with salary in same slot
uint24 private salary;     // Up to 16M salary range
```
**Key Features:** Variable packing, custom errors, access control

---

### 3. **ArraysExercise.sol** - Array Manipulation
```solidity
// Dynamic array operations
function appendToNumbers(uint[] calldata _toAppend) public
function afterY2K() public view returns (uint[] memory, address[] memory)
```
**Key Features:** Dynamic arrays, filtering, timestamp handling

---

### 4. **FavoriteRecords.sol** - Mapping Usage
```solidity
// Nested mappings for user preferences
mapping(address => mapping(string => bool)) public userFavorites;
```
**Key Features:** Nested mappings, approval systems, custom errors

---

### 5. **GarageManager.sol** - Structs & Storage
```solidity
struct Car {
    string make;
    string model; 
    string color;
    uint8 numberOfDoors;  // Gas-optimized
}
```
**Key Features:** Struct optimization, CRUD operations, index validation

---

### 6. **InheritanceExercise.sol** - Advanced Inheritance
```solidity
// Multiple inheritance patterns
contract EngineeringManager is Salaried, Manager
```
**Key Features:** Abstract contracts, virtual/override, multiple inheritance

---

### 7. **ImportsExercise.sol** - Library Integration
```solidity
// External library usage
using SillyStringUtils for string;
```
**Key Features:** Library imports, struct returns, external dependencies

---

### 8. **ErrorTriageExercise.sol** - Debugging & Error Handling
```solidity
// Corrected problematic functions
function diffWithNeighbor() // Fixed underflow issues
function applyModifier()    // Fixed type conversion
function popWithReturn()    // Fixed array bounds
```
**Key Features:** Bug fixes, type safety, boundary checks

---

### 9. **AddressBook.sol + AddressBookFactory.sol** - Factory Pattern
```solidity
// Factory deployment pattern
function deploy() public returns (address) {
    AddressBook newAddressBook = new AddressBook(msg.sender);
    return address(newAddressBook);
}
```
**Key Features:** Factory pattern, Ownable integration, dynamic deployment

---

### 10. **UnburnableToken.sol** - Custom Token
```solidity
// Minimal token with safety checks
function safeTransfer(address _to, uint256 _amount) public
```
**Key Features:** Custom token logic, ETH balance validation, claim system

---

### 11. **WeightedVoting.sol** - ERC-20 Governance
```solidity
// Token-weighted voting system
function vote(uint256 _issueId, Vote _vote) public
```
**Key Features:** ERC-20 compliance, governance, quorum systems

---

### 12. **HaikuNFT.sol** - ERC-721 with Validation
```solidity
// Unique content NFTs
function mintHaiku(string memory _line1, string memory _line2, string memory _line3)
```
**Key Features:** ERC-721 compliance, uniqueness validation, sharing system

## 🚀 Deployment Scripts

Each contract has a corresponding deployment script in the `script/` directory:

| Contract            | Deploy Script                     | Purpose                     |
| ------------------- | --------------------------------- | --------------------------- |
| BasicMath           | `DeployBasicMath.s.sol`           | Math operations with safety |
| EmployeeStorage     | `DeployEmployeeStorage.s.sol`     | Storage optimization demo   |
| ArraysExercise      | `DeployArraysExercise.s.sol`      | Array manipulation          |
| FavoriteRecords     | `DeployFavoriteRecords.s.sol`     | Mapping systems             |
| GarageManager       | `DeployGarageManager.s.sol`       | Struct management           |
| InheritanceExercise | `DeployInheritance.s.sol`         | Inheritance patterns        |
| ImportsExercise     | `DeployImportsExercise.s.sol`     | Library integration         |
| ErrorTriageExercise | `DeployErrorTriageExercise.s.sol` | Debugging solutions         |
| AddressBookFactory  | `DeployAddressBookFactory.s.sol`  | Factory pattern             |
| UnburnableToken     | `DeployUnburnableToken.s.sol`     | Custom token                |
| WeightedVoting      | `DeployWeightedVoting.s.sol`      | ERC-20 governance           |
| HaikuNFT            | `DeployHaikuNFT.s.sol`            | ERC-721 NFTs                |

### Example Deployment
```bash
# Deploy to Base Sepolia testnet
forge script script/DeployWeightedVoting.s.sol \
  --rpc-url https://sepolia.base.org \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify \
  --etherscan-api-key <YOUR-ETHERSCAN-API>
```

## 🔧 Development Workflow

### Building Contracts
```bash
forge build
```

### Running Tests
```bash
forge test
forge test -vvv  # Verbose output
```

### Code Formatting
```bash
forge fmt
```

### Gas Analysis
```bash
forge snapshot
```

### Local Development
```bash
# Start local node
anvil

# Deploy to local node
forge script script/DeployBasicMath.s.sol --rpc-url http://localhost:8545 --private-key <anvil_key> --broadcast
```

## 📁 Project Structure

```
BaseLearn/
├── src/                     # Smart contracts
│   ├── BasicMath.sol
│   ├── EmployeeStorage.sol
│   ├── ArraysExercise.sol
│   ├── FavoriteRecords.sol
│   ├── GarageManager.sol
│   ├── InheritanceExercise.sol
│   ├── ImportsExercise.sol
│   ├── SillyStringUtils.sol
│   ├── ErrorTriageExercise.sol
│   ├── AddressBook.sol
│   ├── AddressBookFactory.sol
│   ├── UnburnableToken.sol
│   ├── WeightedVoting.sol
│   └── HaikuNFT.sol
├── script/                  # Deployment scripts
├── test/                    # Test files
├── lib/                     # Dependencies
└── README.md               # This file
```

## 🌟 Key Learning Concepts Covered

- ✅ **Gas Optimization**: Variable packing, efficient storage patterns
- ✅ **Security**: Overflow/underflow protection, access controls
- ✅ **Design Patterns**: Factory, inheritance, library usage
- ✅ **Standards**: ERC-20, ERC-721 implementations
- ✅ **Error Handling**: Custom errors, debugging techniques
- ✅ **Advanced Features**: Governance systems, uniqueness validation

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📖 Additional Resources

- [Base Learn Documentation](https://docs.base.org/learn/welcome/)
- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

## 📄 License

This project is open source (UNLICENSED) - see individual contract files for details.

---

**Happy Learning! 🎓** This repository represents a journey through Solidity development, from basic concepts to advanced patterns. Each contract builds upon previous knowledge and introduces new concepts essential for blockchain development.
