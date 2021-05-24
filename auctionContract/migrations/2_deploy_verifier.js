/*
const VC10M30M70 = artifacts.require("VC10M30M70");
const VC20M30M70 = artifacts.require("VC20M30M70");
const VC30M30M70 = artifacts.require("VC30M30M70");
const VC40M30M70 = artifacts.require("VC40M30M70");
const VC50M30M70 = artifacts.require("VC50M30M70");
const VC60M30M70 = artifacts.require("VC60M30M70");
*/

const VCC10M30M70 = artifacts.require("VCC10M30M70");
const VCC20M30M70 = artifacts.require("VCC20M30M70");
const VCC30M30M70 = artifacts.require("VCC30M30M70");
const VCC40M30M70 = artifacts.require("VCC40M30M70");
const VCC50M30M70 = artifacts.require("VCC50M30M70");
const VCC60M30M70 = artifacts.require("VCC60M30M70");

module.exports = function(deployer) {
/*
  deployer.deploy(VC10M30M70);
  deployer.deploy(VC20M30M70);
  deployer.deploy(VC30M30M70);
  deployer.deploy(VC40M30M70);
  deployer.deploy(VC50M30M70);
  deployer.deploy(VC60M30M70);
*/

  deployer.deploy(VCC10M30M70);
  deployer.deploy(VCC20M30M70);
  deployer.deploy(VCC30M30M70);
  deployer.deploy(VCC40M30M70);
  deployer.deploy(VCC50M30M70);
  deployer.deploy(VCC60M30M70);

};