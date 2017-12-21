pragma solidity ^0.4.0;

contract MultiNumberBettingV1 {
  uint loserCount;
  uint winnerCount;
  uint[] numArray;
  
  
  // Constructor inokes the constructor of the base class
  function MultiNumberBettingV1(uint num1, uint num2, uint num3) {
    if ((num1 >= 1 && num1 <=10 ) && 
    	(num2 >= 1 && num2 <=10) && 
    	(num3 >= 1 && num3 <=10))
    {
    	numArray.push(num1);
    	numArray.push(num2);
    	numArray.push(num3);
    	
    } 
  }
  
  function guess(uint guess) returns(bool)
  {
        for (uint i = 0; i < numArray.length; i++)
        {
        	if (numArray[i] == guess)  
        	{
        		winnerCount++;
        		return true;
        	}
        }
		loserCount++;        
        return false;
  }
  
  function totalGuesses() constant returns (uint)
  {
  	return (winnerCount + loserCount);
  }  
  
}