// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Product {
    string EIC_code;
    string productName;
    string priceConditions;
    string direction;
    uint256 rampingPeriod;

    constructor(
        string memory _EIC_code,
        string memory _productName,
        string memory _priceConditions,
        string memory _direction,
        uint256 _rampingPeriod
    ) {
        EIC_code = _EIC_code;
        productName = _productName;
        priceConditions = _priceConditions;
        direction = _direction;
        rampingPeriod = _rampingPeriod;
    }

    function getProductDetails()
        external
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            uint256
        )
    {
        return (
            EIC_code,
            productName,
            priceConditions,
            direction,
            rampingPeriod
        );
    }
}
