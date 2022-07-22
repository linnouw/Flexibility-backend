// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Product.sol";
import "./CFT.sol";

contract FlexibilityList {
    Product[] public products;
    Product mFRR;
    Product aFRR;
    CFT[] public cfts;

    constructor() {
        mFRR = new Product("3JP", "mFRR", "card", "-", 50);
        products.push(mFRR);
        aFRR = new Product("2KL", "aFRR", "card", "+", 12);
        products.push(aFRR);
    }

    function createCFT(
        address payable _owner,
        address _productID,
        uint256 _totalPower,
        uint256 _openingDate,
        uint256 _closingDate,
        string calldata _localization
    ) external payable {
        CFT newCFT = new CFT(
            _owner,
            _productID,
            _totalPower,
            _openingDate,
            _closingDate,
            _localization
        );
        cfts.push(newCFT);
    }

    function getAllProducts() external view returns (Product[] memory) {
        return products;
    }

    function getAllCFTs() external view returns (CFT[] memory) {
        return cfts;
    }
}
