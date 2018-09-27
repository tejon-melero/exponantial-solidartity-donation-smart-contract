var ExpoSolidarityDonations = artifacts.require("./ExpoSolidarityDonations.sol");


module.exports = function(deployer) {
  deployer.deploy(ExpoSolidarityDonations, ['0x627306090abab3a6e1400e9345bc60c78a8bef57','0x0F4F2Ac550A1b4e2280d04c21cEa7EBD822934b5','0x5aeda56215b167893e80b4fe645ba6d5bab767de', '0x0d1d4e623d10f9fba5db95830f7d3839406c6af2'], [2, 4, 4, 4]
  ) //Console log the address:
    .then(() => console.log(ExpoSolidarityDonations.address));

};
