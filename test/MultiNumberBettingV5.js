var MultiNumberBettingV5 = artifacts.require("./MultiNumberBettingV5.sol");
/**
 * Execute against TestRPC or other simulators
 * These test cases executed against the actual Ethereum networks may not
 * give expected results as the transaction mining takes time and this code
 * execution is carried out within TestRPC that is almost instantaneous
 */
contract('MultiNumberBettingV5', function(accounts) {
	it("Account[0] should be the last winner address", function() {
	    var multiNumberBettingV5;
	    var john_address = accounts[0];    
	    return MultiNumberBettingV5.deployed().then(function(instance){
	      multiNumberBettingV5 = instance;
	      return multiNumberBettingV5.guess(3, "John Wayne");
	    }).then(function(result){ 
	      return multiNumberBettingV5.getLastWinnerInfo1.call();
	    }).then(function(result){
	      assert.equal(john_address, result[0]);
	    });
	  });
	
	it("Last winner should be John Wayne", function() {
	    var multiNumberBettingV5;
	    var john_address = accounts[0];    
	    return MultiNumberBettingV5.deployed().then(function(instance){
	      multiNumberBettingV5 = instance;
	      return multiNumberBettingV5.guess(3, "John Wayne");
	    }).then(function(result){ 
	      return multiNumberBettingV5.getLastWinnerInfo1.call();
	    }).then(function(result){
	      assert.equal("John Wayne", result[1]);
	    });
	  });
	
	/* Check why balance is 0, probably test on testnet */
	it("Get last balance", function() {
	    var multiNumberBettingV5;
	    var john_address = accounts[0];    
	    return MultiNumberBettingV5.deployed().then(function(instance){
	      multiNumberBettingV5 = instance;
	      return multiNumberBettingV5.guess(3, "John Wayne");
	    }).then(function(result){ 
	      return multiNumberBettingV5.getBalance.call();
	    }).then(function(result){
	      assert.equal(0, result.toNumber());
	    });
	  });		
});
