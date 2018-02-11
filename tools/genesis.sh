ENV=dev
DATADIR="/home/vagrant/.ethereum/${ENV}"
PASSWORDFILE="/home/vagrant/SravzNew/Sravz.BlockChain/password.dev.json"
GENESISFILEORIG="/home/vagrant/SravzNew/Sravz.BlockChain/genesis.dev.orig.json"
GENESISFILE="/home/vagrant/SravzNew/Sravz.BlockChain/genesis.dev.json"

JSPATH="/home/vagrant/SravzNew/Sravz.BlockChain/utils"
PRELOADFILES="utils.js"
IPCPATH="${DATADIR}/geth.ipc"

rm -rf $DATADIR
mkdir $DATADIR

> /tmp/accounts.txt

for id in {1..10}
do
	echo "Creating account ${id}"
	geth --datadir=$DATADIR --password $PASSWORDFILE account new >> /tmp/accounts.txt
done


sed -i 's/Address: {//g' /tmp/accounts.txt
sed -i 's/}//g' /tmp/accounts.txt

cp $GENESISFILEORIG $GENESISFILE
index=0
cat /tmp/accounts.txt | while read line
do
   echo "${index} .. ${line}"
   sed -i "s/Acct${index}/${line}/g" $GENESISFILE
   index=$(($index+1))
done

# create the blockchain with the fund allocations
geth --datadir "${DATADIR}" init ./genesis.dev.json
#geth --port 30303 --networkid 58342 --nodiscover --datadir "${DATADIR}" --maxpeers 0 --rpc --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain * --rpcapi "db,eth,net,web3,personal" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --unlock 0,1,2,3,4,5,6,7,8,9 --password $PASSWORDFILE --jspath $JSPATH --preload $PRELOADFILES --mine 
geth --port 30303 --networkid 58342 --nodiscover --datadir "${DATADIR}" --maxpeers 0 --rpc --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain * --rpcapi "db,eth,net,web3,personal" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --unlock 0,1,2,3,4,5,6,7,8,9 --password $PASSWORDFILE --jspath $JSPATH --preload $PRELOADFILES --mine  --minerthreads 4

geth attach $IPCPATH --jspath $JSPATH --unlock 0,1,2,3,4,5,6,7,8,9 --preload $PRELOADFILES --password $PASSWORDFILE
	