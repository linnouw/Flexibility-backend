// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ActivationRequest{
    enum ARSTATUS{Pending, NoBids}

    address payable owner;
    address productID;
    uint256 quantity;
    string localization;
    uint256 startOfDelivery;
    uint256 createdAt;
    ARSTATUS status;


    constructor(address payable _owner, address _productID, uint256 _quantity, string memory _localization, uint256 _startOfDelivery, uint256 _createdAt) payable{
        owner = _owner;
        productID = _productID;
        quantity = _quantity;
        localization = _localization;
        startOfDelivery = _startOfDelivery;
        createdAt = _createdAt;
        status = ARSTATUS.Pending;
    }

    function getActivationRequestDetails() external view returns(address payable, address, uint256, string memory, uint256, uint256){
        return(owner, productID, quantity, localization, startOfDelivery, createdAt);
    }

    function getLocalization() external view returns(string memory){

        return(localization);
    }

    function getQuantity() external view returns(uint256){

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

    function getOwner() external view returns(address payable){
        return owner;
    }

    function setStatus() external returns(bool){

            status = ARSTATUS.NoBids;
            return true;
    }

    function getStatus() external view returns(ARSTATUS){
        
        return status;

    }

}