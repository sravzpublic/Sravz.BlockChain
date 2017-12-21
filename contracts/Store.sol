pragma solidity ^0.4.0;

contract SimpleStorage {
  uint myVariable;

  function set(uint x) {
    myVariable = x;
  }

  function get() constant returns (uint) {
    return myVariable;
  }
}