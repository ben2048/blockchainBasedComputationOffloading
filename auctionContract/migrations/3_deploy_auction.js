//const Auction = artifacts.require("Auction");
const AuctionConstant = artifacts.require("AuctionConstant");

module.exports = function(deployer) {
  //deployer.deploy(Auction);
  deployer.deploy(AuctionConstant);
};