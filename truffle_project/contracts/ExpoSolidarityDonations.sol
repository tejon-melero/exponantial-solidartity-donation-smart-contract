pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/math/SafeMath.sol';
contract ExpoSolidarityDonations {

    // a smart contract that splits the payments it received into 3 parts:
    // 50% go to the shared wallet of the book authors
    // 25% go to the exponantial Solidarity Foundation wallet adress
    // 25 % go either the address of the Granito a Granito fouondation or to the Ninos de Guarataro Foundation (depending on the book that was sold)


    using SafeMath for uint256;

    // these are the addresses for the payouts. address 1 authors address, address 2 exponantial solidarity address,
    // address 3 Granito a Granito address, address 4 Ninos de Guantaro address
    address[] public payees;
    uint256[] public payoutPercentages;
    mapping(address => uint256) public payeePayoutPercentageMapping;
    mapping(uint256 => address) public soldBookIdNgoPayeeMapping;
    uint256 public granitoAGranitoBookId = 1;
    uint256 public ninosDeGuantaroBookId = 2;

    // this is the constructor that gets called when the contract gets deployed to the blockchain
    function ExpoSolidarityDonations(address[] _payees, uint256[] _payoutPercentages
    ) public {

        require(_payees.length == _payoutPercentages.length);
             for (uint256 i = 0; i < _payees.length; i++) {
                assignPayoutPercentageToPayee(_payees[i], _payoutPercentages[i]);
             }
        // the payee addresses of the exponantial solidity foundation and the authors always the same
        // the payee address of the Ngo depends on which book was sold, this is why we create an addtional
        // mapping here
        require(_payees.length == 4); // the constructor has to pass all needed contract adresses
            assignNgoPayoutAddressToBookId(_payees[2], granitoAGranitoBookId);
            assignNgoPayoutAddressToBookId(_payees[3], ninosDeGuantaroBookId);
    }

    function receivePayment(uint256 amountOfGranitoAGranitoSold, uint256 granitoAGranitoSellingPrice,
        uint256 amountOfNinosOfGuantaroSold, uint256 ninosDeGuantaroSellingPrice  ) external payable
    {
        // todo use the variables of the contract and the parameters of this function to distribute the received funds
        // todo other addresses
        // todo to make a transfer call the following function
        // todo address.transfer(msg.value) --> this will transfer a given amount to the address
        uint256 totalPaymentAmountReceived = msg.value; // --> this is the amount that was paid to the smart contract

        // todo just for demonstration purposes we transfer the full received amount to the authors account
        // todo change this with the right logic
        payees[0].transfer(msg.value);
    }



      function assignPayoutPercentageToPayee(address _payee, uint256 _payoutPercentage) internal {
        require(_payee != address(0));
        require(_payoutPercentage > 0);
        require(payeePayoutPercentageMapping[_payee] == 0);

        payees.push(_payee);
        payeePayoutPercentageMapping[_payee] = _payoutPercentage;
    }

    function assignNgoPayoutAddressToBookId(address _payee, uint256 _bookId) internal {
        require(_payee != address(0));
        require(_bookId > 0);
        soldBookIdNgoPayeeMapping[_bookId] = _payee;
    }




    function getAllPayees() view public returns (address[]){
        return payees;
    }
}
