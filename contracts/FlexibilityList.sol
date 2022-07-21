// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Product.sol";
import "./CFT.sol";

contract FlexibilityList{
    
    Product[] public products;
    CFT[] public cfts;
    
    function createProduct(address payable _owner, string calldata _EIC_code, string calldata _productName, string calldata _priceConditions, string calldata _direction, uint256 _rampingPeriod) external payable{
        Product myNewProduct= new Product(_owner, _EIC_code,  _productName, _priceConditions, _direction, _rampingPeriod);
        products.push(myNewProduct);
    }

    function createCFT(address payable _owner, address _productID, uint256 _totalPower, uint256 _openingDate, uint256 _closingDate, string calldata _localization) external payable {
        
        CFT newCFT= new CFT(_owner, _productID, _totalPower, _openingDate, _closingDate, _localization);
        cfts.push(newCFT);
    }

    function getAllProducts() external view returns(Product[] memory) {
        
        return products;
    }

    function getAllCFTs() external view returns(CFT[] memory) {
        
        return cfts;
    }


}