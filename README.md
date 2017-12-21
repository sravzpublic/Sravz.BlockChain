# Truffle develop helpful commands
## Loop through all accounts
web3.eth.accounts.forEach(function(item) {console.log(item); console.log(web3.fromWei(web3.eth.getBalance(item), "ether"))})
## Transfer funds from one account to another
web3.eth.sendTransaction({ from: web3.eth.accounts[9], to: web3.eth.accounts[0], value: web3.toWei(90, "ether") });
 