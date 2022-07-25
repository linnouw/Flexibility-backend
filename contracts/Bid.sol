// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bid{

    address payable owner;
    string serviceProvider;
    uint256 price;
    address productID;
    uint256 quantity;
    string localization;
    uint256 startOfDelivery;
    uint256 createdAt;
    
    constructor(address payable _owner, string memory _serviceProvider, uint256 _price, address _productID, uint256 _quantity, string memory _localization, uint256 _startOfDelivery, uint256 _createdAt) payable{
        owner = _owner;
        serviceProvider = _serviceProvider;
        price = _price;
        productID = _productID;
        quantity = _quantity;
        localization = _localization;
        startOfDelivery = _startOfDelivery;
        createdAt = _createdAt;
    }

    function getBidDetails() public view returns(address payable, string memory, uint256, address, uint256, string memory, uint256, uint256){
        
        return(owner, serviceProvider, price, productID, quantity, localization,  startOfDelivery, createdAt);
    }

    function getPrice() external view returns(uint256){
        
        return (price);
    }

    function getLocalization() external view returns(string memory){

        return(localization);
    }

    function getQuantity() external view returns(uint){
        
        return(quantity);
    }

    function setQuantity(uint256 _qte) external returns(bool){
        
        quantity = _qte;

        return true;
    }

    function getCreatedAt() external view returns(uint256){
        
        return createdAt;
    }

    function getStartOfDelivery() external view returns(uint256){
        
        return startOfDelivery;
    }

}