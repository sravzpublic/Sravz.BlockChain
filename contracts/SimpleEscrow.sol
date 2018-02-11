pragma solidity ^0.4.18;

contract SimpleEscrow{

  mapping (address => uint) balances;

  address public seller;
  address public buyer;
  address escrow = msg.sender;
  bool sellerApprove;
  bool buyerApprove;

  modifier ownerOnly {
    if(msg.sender == escrow){
      _;
    } else {
      revert();
    }
  }
  
  function setup(address _seller, address _buyer) public {
    if(msg.sender == escrow){
        seller = _seller;
        buyer = _buyer;
    }
  }

  function approve() public {
    if(msg.sender == buyer) buyerApprove = true;
    else if(msg.sender == seller) sellerApprove = true;
    if(sellerApprove && buyerApprove) fee();
  }

  function abort() public {
      if(msg.sender == buyer) buyerApprove = false;
      else if (msg.sender == seller) sellerApprove = false;
      if(!sellerApprove && !buyerApprove) refund();
  }

  function payOut() public ownerOnly {
    seller.transfer(this.balance);
    balances[buyer] = 0;
  }

  function deposit() public payable {
      if(msg.sender == buyer) balances[buyer] += msg.value;
      else revert();
  }

  function killContract() public ownerOnly {
      selfdestruct(escrow);
      //kills contract and returns funds to buyer
  }

  function refund() public {
    if(buyerApprove == false && sellerApprove == false) selfdestruct(buyer);
    //send money back to recipient if both parties agree contract is void
  }

  function fee() internal {
      escrow.transfer(this.balance / 100); //1% fee
      payOut();
  }

}