pragma solidity ^0.4.25;

contract ElectionFact {
    
    struct ElectionDet {
        address deployedAddress;
        string el_n;
        string el_d;
    }
    
    mapping(string=>ElectionDet) companyEmail;
    
    function createElection(string memory email,string memory election_name, string memory election_description) public{
        address newElection = new Election(msg.sender , election_name, election_description);
        
        companyEmail[email].deployedAddress = newElection;
        companyEmail[email].el_n = election_name;
        companyEmail[email].el_d = election_description;
    }
    
    function getDeployedElection(string memory email) public view returns (address,string,string) {
        address val =  companyEmail[email].deployedAddress;
        if(val == 0) 
            return (0,"","Create an election.");
        else
            return (companyEmail[email].deployedAddress,companyEmail[email].el_n,companyEmail[email].el_d);
    }
}

contract Election {

    //election_authority's address
    address election_authority;
    string election_name;
    string election_description;
    bool status;

    //election_authority's address taken when it deploys the contract
    constructor(address authority , string name, string description) public {
        election_authority = authority;
        election_name = name;
        election_description = description;
        status = true;
    }

    //Only election_authority can call this function
    modifier owner() {
        require(msg.sender == electionauthority, "Error: Access Denied.");
        ;
    }
    //candidate election_description

    struct Candidate {
        string candidate_name;
        string candidate_description;
        string imgHash;
        uint8 voteCount;
        string email;
    }
    //function to get count of candidates

    function getNumOfCandidates() public view returns(uint8) {
        return numCandidates;
    }

    //function to get count of voters

    function getNumOfVoters() public view returns(uint8) {
        return numVoters;
    }

    //function to get candidate information

    function getCandidate(uint8 candidateID) public view returns (string memory, string memory, string memory, uint8,string memory) {
        return (candidates[candidateID].candidate_name, candidates[candidateID].candidate_description, candidates[candidateID].imgHash, candidates[candidateID].voteCount, candidates[candidateID].email);
    } 

    //function to return winner candidate information

    function winnerCandidate() public view owner returns (uint8) {
        uint8 largestVotes = candidates[0].voteCount;
        uint8 candidateID;
        for(uint8 i = 1;i<numCandidates;i++) {
            if(largestVotes < candidates[i].voteCount) {
                largestVotes = candidates[i].voteCount;
                candidateID = i;
            }
        }
        return (candidateID);
    }
    
    function getElectionDetails() public view returns(string, string) {
        return (election_name,election_description);    
    }
}