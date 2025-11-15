// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract voting{
    struct vote{
        address voter;
        uint cand_no;
    }
    vote[] public votes;

    uint public cand1_vote = 0;
    uint public cand2_vote = 0;
    uint public total_votes=0;
    uint public result;
    address public owner;
    uint max_votes;
    constructor(uint _max_votes) {
        owner = msg.sender;
         max_votes = _max_votes;
    
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    string public cand1_name;
    string public cand2_name;
    bool public cand_set = false;
    bool public voting_open=false;
    bool public voting_ended=false;

     function set_cand_name(string memory _cand1, string memory _cand2) onlyOwner public {
        require(cand_set==false, "Already set!");
        cand1_name = _cand1;
         cand2_name = _cand2;
        cand_set = true;
        voting_open=true;
    }
    function put_vote(uint _cand_no)public {
        require(cand_set == true, "Team name not set yet!");
        require(voting_open==true,"voting closed");
        require(_cand_no==1|| _cand_no ==2, "Invalid Candidate number");
        
        
        if(_cand_no==1){
            cand1_vote++;
        }
        else {
            cand2_vote++;
        }
        total_votes++;
    }
   
    function declare_result() public onlyOwner {
         voting_open =false;
        require(voting_open==false,"voting still open");
        uint winner;
        if(cand1_vote>cand2_vote)winner=1;
        else if(cand1_vote<cand2_vote)winner=2;
        else winner=0;//if tie then result=0
        result =winner;
        voting_ended=true;
    }



    
}