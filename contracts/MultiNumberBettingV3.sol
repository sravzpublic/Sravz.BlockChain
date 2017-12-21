pragma solidity ^0.4.0;

contract MultiNumberBettingV3 {
  uint public loserCount;
  uint public winnerCount;
  uint[] numArray;
  string lastWinnerName;
  uint public lastWinnerAt;
  address public winner;
  
 function MultiNumberBettingV3(uint num1, uint num2, uint num3) {
    if ((num1 >= 1 && num1 <=10 ) && 
    	(num2 >= 1 && num2 <=10) && 
    	(num3 >= 1 && num3 <=10))
    {
    	numArray.push(num1);
    	numArray.push(num2);
    	numArray.push(num3);
    	
    } 
  }
  
  function guess(uint guess, string name, address caller) returns(bool)
  {
        require(guess >=0 && guess <= 10);
  		
        for (uint i = 0; i < numArray.length; i++)
        {
        	if (numArray[i] == guess)  
        	{
        		winnerCount++;
        		lastWinnerName = name;
        		lastWinnerAt = now;
        		winner = caller;
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
  
  function getWinnerName() constant returns (string)
  {
    bytes memory _lastName = bytes(lastWinnerName);
    if (_lastName.length == 0) {
        return '***';
    }
    else
    {
	    bytes memory bytesStringTrimmed = new bytes(3);
	    for (uint j = 0; j < 3; j++) {
	        bytesStringTrimmed[j] = _lastName[j];
	    }
	    return string(bytesStringTrimmed);    	
    }  	
  }      
  
  function daysSinceLastWinning() constant returns (uint)
  {
  		return ( (now - lastWinnerAt) * 1 days );	
  }
  
  function hoursSinceLastWinning() constant returns (uint)
  {
  		return ( (now - lastWinnerAt) * 1 hours );
  }

  function minutesSinceLastWinning() constant returns (uint)
  {
  		return ( (now - lastWinnerAt) * 1 minutes);
  }
 
}