pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/math/SafeMath.sol';
contract ExpoSolidarityDonations {

    // a smart contract that splits the payments it received into 3 parts:
    // 50% go to the shared wallet of the book authors
    // 25% go to the exponantial Solidarity Foundation wallet adress
    // 25 % go either the address of the Granito a Granito fouondation or to the Ninos de Guarataro Foundation
    //(depending on the book that was sold)
    // we require that each of the books has the same price (That way we can easily calculate the rations and
    // donation amounts

    using SafeMath for uint256;

    // these are the addresses for the payouts. address 1 authors address, address 2 exponantial solidarity address,
    // address 3 Granito a Granito address, address 4 Ninos de Guantaro address
    address[] public payees;
    uint256[] public payoutPercentages;
    mapping(address => uint256) public payeePayoutPercentageMapping;
    mapping(uint256 => address) public soldBookIdNgoPayeeMapping;

    uint256 donationsSentToGranitoGranito;
    uint256 donationsSentToNinosDeGuantaro;

    // this is the constructor that gets called when the contract gets deployed to the blockchain
    function ExpoSolidarityDonations(address[] _payees, uint256[] _payoutPercentages
    ) public {

        require(_payees.length == _payoutPercentages.length);
             for (uint256 i = 0; i < _payees.length; i++) {
                assignPayoutPercentageToPayee(_payees[i], _payoutPercentages[i]);
             }

        require(_payees.length == 4); // the constructor has to pass all needed contract adresses
    }


    function receivePayment(uint256 _amountOfGranitoAGranitoSold,
        uint256 _amountOfNinosOfGuantaroSold) external payable
    {

        bool bookForGranitoGranitoSold = false;
        bool bookForNinosDeGuantaroSold = false;
        uint amountToTransferToGranitoGranitoNgo;
        uint amountToTransferToNinosDeGuantaroNgo;
        uint256 totalPaymentAmountReceived = msg.value; // --> this is the amount that was paid to the smart contract

        uint256 totalAmountOfUnitsSold = _amountOfNinosOfGuantaroSold.add(_amountOfGranitoAGranitoSold);
        // we require that each book has the same price that way we can easily determine the revenue created
        // for each book in this transaction
        uint256 bookUnitPrice = totalPaymentAmountReceived.div(totalAmountOfUnitsSold);

        // 50% to go to the shared wallet of the authors
        uint amountToTransferToSharedWalletOfAuthors = totalPaymentAmountReceived.div(2);

        // 25% to go to the Exponantial Solidarity Foundation
        uint amountToTransferToExpoSolidarityFoundation = totalPaymentAmountReceived.div(4);

        if(_amountOfGranitoAGranitoSold > 0){
            bookForGranitoGranitoSold = true;
            uint amountOfMoneyEarnedForGranitoGranito = _amountOfGranitoAGranitoSold.mul(bookUnitPrice);
            // 25% of the sold revenue of this book gets donated
            amountToTransferToGranitoGranitoNgo = amountOfMoneyEarnedForGranitoGranito.div(4);
        }
        if(_amountOfNinosOfGuantaroSold > 0){
            bookForNinosDeGuantaroSold = true;
            // 25 of the sold revenue of this book gets donated
            uint amountOfMoneyEarnedForNinosDeGuantaro = _amountOfNinosOfGuantaroSold.mul(bookUnitPrice);
            amountToTransferToNinosDeGuantaroNgo = amountOfMoneyEarnedForNinosDeGuantaro.div(4);

        }

        // now we redistribute the funds:
        payees[0].transfer(amountToTransferToSharedWalletOfAuthors);
        payees[1].transfer(amountToTransferToExpoSolidarityFoundation);
        if(bookForGranitoGranitoSold){
            payees[2].transfer(amountToTransferToGranitoGranitoNgo);
            donationsSentToGranitoGranito = donationsSentToGranitoGranito + amountToTransferToGranitoGranitoNgo;
        }
        if(bookForNinosDeGuantaroSold){
            payees[3].transfer(amountToTransferToNinosDeGuantaroNgo);
            donationsSentToNinosDeGuantaro = donationsSentToNinosDeGuantaro + amountToTransferToNinosDeGuantaroNgo;
        }
    }

    function assignPayoutPercentageToPayee(address _payee, uint256 _payoutPercentage) internal {
        require(_payee != address(0));
        require(_payoutPercentage > 0);
        require(payeePayoutPercentageMapping[_payee] == 0);

        payees.push(_payee);
        payeePayoutPercentageMapping[_payee] = _payoutPercentage;
    }


    function getTotalDonationsReceivedForGranitoGranito() view public returns (uint256){
        return donationsSentToGranitoGranito;
    }

    function getTotalDonationsReceivedForNinosDeGuantaro() view public returns (uint256){
        return donationsSentToGranitoGranito;
    }
}
