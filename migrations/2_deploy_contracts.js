var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var String = artifacts.require("./String.sol");
var SpecialArrays = artifacts.require("./SpecialArrays.sol");
var Funcs = artifacts.require("./Funcs.sol");
var MappingEnumStruct = artifacts.require("./MappingEnumStruct.sol");
var FuncTypes = artifacts.require("./FuncTypes.sol");
var FuncTypesCaller = artifacts.require("./FuncTypesCaller.sol");
var Globals = artifacts.require("./Globals.sol");
var ConstantsPayable = artifacts.require("./ConstantsPayable.sol");
var Modifiers = artifacts.require("./Modifiers.sol");
var Events = artifacts.require("./Events.sol");
var SimpleStorage = artifacts.require("SimpleStorage");
var MultiNumberBettingV1 = artifacts.require("MultiNumberBettingV1");
var MultiNumberBettingV2 = artifacts.require("MultiNumberBettingV2");
var MultiNumberBettingV3 = artifacts.require("MultiNumberBettingV3");
var MultiNumberBettingV4 = artifacts.require("MultiNumberBettingV4");
var MultiNumberBettingV5 = artifacts.require("MultiNumberBettingV5");
var MultiNumberBettingV6 = artifacts.require("MultiNumberBettingV6");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(String);
  deployer.deploy(SpecialArrays);
  deployer.deploy(MappingEnumStruct);

  // Provide the constructor parameters
  // string name, uint8 age
  deployer.deploy(Funcs,"Nelson",31);

  deployer.deploy(FuncTypes);
  deployer.deploy(FuncTypesCaller);
  
  deployer.deploy(Globals);
  deployer.deploy(ConstantsPayable);

  deployer.deploy(Modifiers);
  deployer.deploy(Events);

  
  // Simple storage
  deployer.deploy(SimpleStorage);
  
  // MultiNumber betting
  deployer.deploy(MultiNumberBettingV1, 3, 4, 5);
  deployer.deploy(MultiNumberBettingV2, 3, 4, 5);
  deployer.deploy(MultiNumberBettingV3, 3, 4, 5);
  deployer.deploy(MultiNumberBettingV4, 3, 4, 5);
  deployer.deploy(MultiNumberBettingV5, 3, 4, 5);
  deployer.deploy(MultiNumberBettingV6, 3, 4, 5);
  
};
