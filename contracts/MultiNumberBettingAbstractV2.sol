
pragma solidity ^0.4.18;

contract MultiNumberBettingAbstractV2 {

  uint constant MAX_BET = 0.0005 ether; 
  uint constant MIN_BET = 0.000001 ether;
  
  struct Winner {
	string name;
	address _address;
    uint guess;
    uint guessedAt;
    uint ethersReceived;
  }
  
  function guess(uint guess, string name) payable returns(bool);
  
  function totalGuesses() constant returns (uint);
  
  function getLastWinnerInfo() returns (Winner);
  
  function getLastWinnerInfo1() returns (address winnerAddress,
                                         string  name,
                                         uint    guess,
                                         uint    guessedAt,
                                         uint    ethersReceived);
  
    
  function checkWinning(address _address) returns(Winner);
  
  function daysSinceLastWinning() constant returns (uint);
  
  function hoursSinceLastWinning() constant returns (uint);

  function minutesSinceLastWinning() constant returns (uint);
 
}