pragma solidity ^0.6.0;

contract Product {

    enum Statuses {Paid, NotPaid}
    Statuses public currentStatus;

    event Bought(address _buyer, uint _value);

    address payable public owner;

    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.NotPaid;
    }

    modifier onlyWhileNotPaid{
        require(currentStatus == Statuses.NotPaid,
        "Impossible to proceed.");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value = _amount,
        "Not enough currency provided.");
        _;
    }

    function pay() external payable onlyWhileNotPaid costs(10 ether) {
        currentStatus = Statuses.Paid;
        owner.transfer(msg.value);
        emit Bought(msg.sender, msg.value);
    }

}
