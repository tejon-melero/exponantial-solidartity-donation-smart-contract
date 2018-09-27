# Exponantial Solidarity Donation Contract
## A smart contract that automatically sends a part of the payment that splits the payment it receives and sends the parts to pre defined-contract adresses  <br>

# Installation

## run a local development blockchain and compile the contracts:

`npm install -g truffle` <br>
` truffle develop` --> this will also run a local test blockchain on your machine on port 9545

within the development console run
`compile`
`migrate --reset`

# set the right initial values for the ExpoSolidarityDonations contract
in the file `migrations/2_deploy_contracts.js` change the payee addresses in this line to the 4 needed addresses: 
[addressOfSharedBookdAuthorsWallet, addressOfExponantialSolidityWallet, addressOfGranitoGranitoNgoWallet, addressOfNinosDeGuantaroNgoWallet]
<br>
`deployer.deploy(ExpoSolidarityDonations, '0x627306090abab3a6e1400e9345bc60c78a8bef57', '0xf17f52151ebef6c7334fad080c5704d77216b732');`
<br>
to 4 addresses from the truffle develop command that you ran before



## Install Metamask and connect it to your locally running blockchain.

Metamask https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn
after setting up metamask connect it to your local blockchain: (connect to the local blockchain that runs on port 9545)

the command truffle develop outputed some private keys created on your local blockchain.
In the metamask extension click on import account and type in one of the private keys from the truffle develop command


