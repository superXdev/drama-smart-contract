// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Ownable {
    address public _owner;

    event TransferOWnership(address newOwner);
    event RenounceOwnership();

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "You don't have access to do this");
        _;
    }

    function transferOwnership(address ownerAddress) public onlyOwner {
        require(ownerAddress != address(0), "Nulled address not allowed");

        _owner = ownerAddress;

        emit TransferOWnership(ownerAddress);
    }

    function renounceOwnership() public onlyOwner {
        _owner = address(0);

        emit RenounceOwnership();
    }
}