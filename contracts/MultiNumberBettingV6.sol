pragma solidity ^0.4.18;

import "./MultiNumberBettingAbstractV2.sol";

contract MultiNumberBettingV6 is MultiNumberBettingAbstractV2 { 
  
  mapping (address => Winner) Winners;
  address public owner;
  address lastWinnerAddress;
  string  public  lastCaller;
  address public  lastSender;
  uint    public  lastReceived=0;
  uint public loserCount;
  uint public winnerCount;
  uint lastWinnerAt;
  uint[] numArray;

 function MultiNumberBettingV6(uint num1, uint num2, uint num3) {
    if ((num1 >= 1 && num1 <=10 ) && 
    	(num2 >= 1 && num2 <=10) && 
    	(num3 >= 1 && num3 <=10))
    {
    	numArray.push(num1);
    	numArray.push(num2);
    	numArray.push(num3);
    	
    } 
    
    owner = msg.sender;
  }
      
  // Restricts execution by owner only
  modifier  ownerOnly {
    if(msg.sender == owner){
      _;
    } else {
      revert();
    }
  }

  function receiveEthers(string name) payable   {
    lastSender = msg.sender;
    lastReceived = msg.value;
    lastCaller = name;
  }
        
 function ownerWithdraw(uint amt) returns (bool) {
    if (this.balance - amt <= 2 * MAX_BET)
    {
    	revert();
    }
 	owner.transfer(amt * 1 ether);
 }
  
  function guess(uint guess, string name) payable returns(bool)
  {
        require(guess >=0 && guess <= 10);
  		
  		require(this.balance > 2*MAX_BET);
  		
        for (uint i = 0; i < numArray.length; i++)
        {
        	if (numArray[i] == guess)  
        	{
        		winnerCount++;
        		Winners[msg.sender] = Winner(name, msg.sender, guess, now, msg.value);
        		lastWinnerAddress = msg.sender;
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
                                         uint    guessedAt,
                                         uint    ethersReceived){
    winnerAddress = Winners[lastWinnerAddress]._address;
    name =  Winners[lastWinnerAddress].name;
    guess = Winners[lastWinnerAddress].guess;
    guessedAt = Winners[lastWinnerAddress].guessedAt;
    ethersReceived = Winners[lastWinnerAddress].ethersReceived;
    winnerAddress.transfer(ethersReceived);
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
  
  function getBalance() returns (uint) {
        return this.balance;
  }
 
  // Fallback function
  // This function gets invoked when contract receives ethers
  // without the function data. 
  function() payable  {
    // Max gas that can be spent in this function is 2300
    // msg.value has the number wei received
    // msg.sender has the address of the sender

    // As a BEST practice just log an Event here

    // If you do not want to receive ethers in the contract
    // then throw exception here
  } 
}
