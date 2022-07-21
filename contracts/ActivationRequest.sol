// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ActivationRequest{
    //status = 
    //["No bids on the MOL", 
    //"No feedback from FSP", 
    //"Activation order confirmed by FSP", 
    //"Activation order rejected by FSP"]
    address payable owner;
    address productID;
    uint256 quantity;
    string localization;
    uint256 startOfDelivery;
    uint256 createdAt;
    ARSTATUS status;

    enum ARSTATUS {Pending, NoBids, NoFeedback, AOConfirmed, AORejected}

    constructor(address payable _owner, address _productID, uint256 _quantity, string memory _localization, uint256 _startOfDelivery, uint256 _createdAt) public payable{
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

    function setStatus(uint _status) external returns(bool){
        if (_status == 1)
            status = ARSTATUS.NoBids;
        else if (_status == 2)
            status = ARSTATUS.NoFeedback;
        else if (_status == 3)
            status = ARSTATUS.AOConfirmed;
        else
            status = ARSTATUS.AORejected;

        return true;
    }

    function getStatus() external view returns(string memory){
        if (uint(status) == 0)
            return ("Pending");
        else if(uint(status) == 1)
            return("No bids on the MOL");
        else if(uint(status) == 2)
            return ("No feedback from FSP");
        else if(uint(status) == 3)
            return("Activation order confirmed by FSP");
        else
            return("Activation order rejected by FSP");
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

    function getOwner() external view returns(address payable){
        return owner;
    }

}