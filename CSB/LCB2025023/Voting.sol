//SPDX Licence-Identifier: MIT

pragma solidity ^ 0.8.20;

contract Voting{
    address public owner;
    struct party_details{
        string name;
        uint votes;
    }
    mapping(address => bool) public voters;
    

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender==owner, "You are not the owner");
        _;
    }
    party_details[] public parties;
    string public winner_party_name="NONE";
    uint public winner_party_votes=0;
    uint public total_votes=0;
    bool public voting_running=false;

    function add_party(uint party_num,string memory party_name) public onlyOwner{
        require(voting_running==false,"Voting is going on...");
        require(party_num>parties.length);
        
        parties.push(party_details(party_name,0));

    }

    function voting_begin() public onlyOwner{
        require(voting_running==false, "Voting already Started");
    

        voting_running=true;
    
    }

    function vote(uint party_no) public{
        require(voting_running==true, "Voting haven't started Yet!!");
        require(party_no<=parties.length,"Invalid party number");
        require(!voters[msg.sender],"You have already voted");
        parties[party_no+1].votes++;
        total_votes++;
        voters[msg.sender]=true;
    }

    function end_voting() public onlyOwner{
        require(voting_running==true,"Voting haven't started yet");
        voting_running=false;
    }

    function declare_result(uint winner_party_no) public onlyOwner{
        require(voting_running==false,"voting still going on..");
        require(winner_party_no<=parties.length,"Invalid party number");
            
        winner_party_name=parties[winner_party_no-1].name;
        winner_party_votes=parties[winner_party_no-1].votes;
        

    }


}