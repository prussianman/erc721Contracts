// const { toChecksumAddress } = require('ethereum-checksum-address')

var OIO_mother = artifacts.require("./OIO_mother.sol");
// var daughter_contract = artifacts.require("./daughter_contract.sol");


module.exports = function(deployer) {
    // deployer.deploy(OIO_mother).then(function() {
    //     return deployer.deploy(daughter_contract, toChecksumAddress(OIO_mother.address), '0xf39991A3d537E5425b971BA990499a6ceca4B5f5', `0x32d8f159027a88F3eD48AfD7158e909DBE35aa24`);
    // })
    deployer.deploy(OIO_mother)
    // deployer.deploy(daughter_contract, '0x881dC5D80DA959581badc5f1C3989e47E955adCB', '0xf39991A3d537E5425b971BA990499a6ceca4B5f5', `0x32d8f159027a88F3eD48AfD7158e909DBE35aa24`);

}



