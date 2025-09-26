// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract WeightedVoting is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet;

    // Maximum supply constant
    uint256 public constant maxSupply = 1000000;

    // Custom errors
    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh(uint256 quorum);
    error AlreadyVoted();
    error VotingClosed();

    // Vote enum
    enum Vote {
        AGAINST,
        FOR,
        ABSTAIN
    }

    // Issue struct (in required order)
    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 votesAbstain;
        uint256 totalVotes;
        uint256 quorum;
        bool passed;
        bool closed;
    }

    // Return struct for getIssue (without EnumerableSet)
    struct ReturnableIssue {
        address[] voters;
        string issueDesc;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 votesAbstain;
        uint256 totalVotes;
        uint256 quorum;
        bool passed;
        bool closed;
    }

    // Storage
    Issue[] private issues;
    mapping(address => bool) public hasClaimed;

    constructor() ERC20("WeightedVoting", "WV") {
        // Burn the zeroeth element by creating an empty issue
        issues.push();
        issues[0].closed = true; // Mark as closed/burned
    }

    // Claim tokens function
    function claim() public {
        // Check if user has already claimed
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        // Check if all tokens have been claimed
        if (totalSupply() + 100 > maxSupply) {
            revert AllTokensClaimed();
        }

        // Mark user as having claimed and mint tokens
        hasClaimed[msg.sender] = true;
        _mint(msg.sender, 100);
    }

    // Create issue function
    function createIssue(
        string calldata _issueDesc,
        uint256 _quorum
    ) external returns (uint256) {
        // Check if user holds tokens
        if (balanceOf(msg.sender) == 0) {
            revert NoTokensHeld();
        }

        // Check if quorum is not too high
        if (_quorum > totalSupply()) {
            revert QuorumTooHigh(_quorum);
        }

        // Create new issue
        issues.push();
        uint256 issueIndex = issues.length - 1;

        Issue storage newIssue = issues[issueIndex];
        newIssue.issueDesc = _issueDesc;
        newIssue.quorum = _quorum;
        newIssue.votesFor = 0;
        newIssue.votesAgainst = 0;
        newIssue.votesAbstain = 0;
        newIssue.totalVotes = 0;
        newIssue.passed = false;
        newIssue.closed = false;

        return issueIndex;
    }

    // Get issue function
    function getIssue(
        uint256 _id
    ) external view returns (ReturnableIssue memory) {
        Issue storage issue = issues[_id];

        // Convert EnumerableSet to array
        address[] memory votersArray = new address[](issue.voters.length());
        for (uint256 i = 0; i < issue.voters.length(); i++) {
            votersArray[i] = issue.voters.at(i);
        }

        return
            ReturnableIssue({
                voters: votersArray,
                issueDesc: issue.issueDesc,
                votesFor: issue.votesFor,
                votesAgainst: issue.votesAgainst,
                votesAbstain: issue.votesAbstain,
                totalVotes: issue.totalVotes,
                quorum: issue.quorum,
                passed: issue.passed,
                closed: issue.closed
            });
    }

    // Vote function
    function vote(uint256 _issueId, Vote _vote) public {
        Issue storage issue = issues[_issueId];

        // Check if issue is closed
        if (issue.closed) {
            revert VotingClosed();
        }

        // Check if user has already voted
        if (issue.voters.contains(msg.sender)) {
            revert AlreadyVoted();
        }

        // Get user's token balance
        uint256 voterTokens = balanceOf(msg.sender);

        // Add voter to the set
        issue.voters.add(msg.sender);

        // Add votes based on the vote type
        if (_vote == Vote.FOR) {
            issue.votesFor += voterTokens;
        } else if (_vote == Vote.AGAINST) {
            issue.votesAgainst += voterTokens;
        } else {
            issue.votesAbstain += voterTokens;
        }

        // Update total votes
        issue.totalVotes += voterTokens;

        // Check if quorum is reached
        if (issue.totalVotes >= issue.quorum) {
            issue.closed = true;

            // Check if more votes for than against
            if (issue.votesFor > issue.votesAgainst) {
                issue.passed = true;
            }
        }
    }
}
