var MultiNumberBettingV6 = artifacts.require("./MultiNumberBettingV6.sol");
var accounts;
web3.eth.getAccounts(function(err,res) { accounts = res; });
/**
 * Execute against TestRPC or other simulators
 * These test cases executed against the actual Ethereum networks may not
 * give expected results as the transaction mining takes time and this code
 * execution is carried out within TestRPC that is almost instantaneous
 */
contract('MultiNumberBettingV6', function(accounts) {
	it("Should send and receive 1000 wei", function() {
	    var multiNumberBettingV6;
	    return MultiNumberBettingV6.deployed().then(function(instance){
	      multiNumberBettingV6 = instance;
	      web3.eth.sendTransaction({ from: accounts[0], to: multiNumberBettingV6.address, value: web3.toWei(2, "ether") });
	    }).then(function(result){ 
	      return multiNumberBettingV6.getBalance.call();
	    }).then(function(result){
	    	assert.equal(2, web3.fromWei(result.toNumber(), "ether") , "Send receive same amount!!");
	    });
	  });
	
	it("Owner should be able to withdraw funds", function() {
	    var multiNumberBettingV6;
	    return MultiNumberBettingV6.deployed().then(function(instance){
	      multiNumberBettingV6 = instance;
	      web3.eth.sendTransaction({ from: accounts[1], to: multiNumberBettingV6.address, value: web3.toWei(3, "ether") });
	    }).then(function(result){ 
	    	return multiNumberBettingV6.ownerWithdraw.call(1);
	    }).then(function(result){
	    	assert.equal(true, result, "Withdraw should return true");
	    }).then(function(result){
	        return multiNumberBettingV6.getBalance.call();
	    }).then(function(result){
	    	assert.equal(3, web3.fromWei(result.toNumber(), "ether") , "Send receive same amount!!");
	    });
	  });	
});
