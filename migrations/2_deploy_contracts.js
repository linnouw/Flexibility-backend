const FlexibilityList = artifacts.require("FlexibilityList");
const NFT = artifacts.require("NFT");

module.exports = async function (deployer) {
  deployer.deploy(FlexibilityList);
  deployer.deploy(NFT);
  
};
