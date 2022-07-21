// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Product{
    
    address payable owner;
    string EIC_code;
    string productName;
    string priceConditions;
    string direction;
    uint256 rampingPeriod;

    constructor(address payable _owner, string memory _EIC_code, string memory _productName, string memory _priceConditions, string memory _direction, uint256 _rampingPeriod) public payable{
        owner = _owner;
        EIC_code = _EIC_code;
        productName = _productName;
        priceConditions = _priceConditions;
        direction = _direction;
        rampingPeriod = _rampingPeriod;
    }

    function getProductDetails() external view returns(address payable, string memory, string memory, string memory, string memory, uint256){
        return(owner, EIC_code, productName, priceConditions, direction, rampingPeriod);
    }

}