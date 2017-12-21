pragma solidity ^0.4.0;

contract MultiNumberBettingV4 {

  struct Winner {
	string name;
	address _address;
    uint guess;
    uint guessedAt;
  }
  
  mapping (address => Winner) Winners;
  address lastWinnerAddress;  
  uint public loserCount;
  uint public winnerCount;
  uint lastWinnerAt;
  uint[] numArray;
  
 function MultiNumberBettingV4(uint num1, uint num2, uint num3) {
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
        		Winners[caller] = Winner(name, caller, guess, now);
        		lastWinnerAddress = caller;
        		lastWinnerAt = now;
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

  /*  
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
  */
  
  function getLastWinnerInfo() returns (Winner)
  {
	return Winners[lastWinnerAddress];  	
  }
  
  
  function getLastWinnerInfo1() returns (address winnerAddress,
                                         string  name,
                                         uint    guess,
                                         uint    guessedAt){
    winnerAddress = Winners[lastWinnerAddress]._address;
    name =  Winners[lastWinnerAddress].name;
    guess = Winners[lastWinnerAddress].guess;
    guessedAt = Winners[lastWinnerAddress].guessedAt;
  }
  
    
  function checkWinning(address _address) returns(Winner)
  {
  	return Winners[_address];
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