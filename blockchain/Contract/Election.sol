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
