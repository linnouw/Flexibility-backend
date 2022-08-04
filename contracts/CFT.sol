// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ActivationRequest.sol";
import "./Bid.sol";
import "./FlexibilityDP.sol";
import "./Product.sol";

contract CFT {
    ActivationRequest[] public aRs;
    Bid[] public bids;
    Bid[] public unsortedBids;
    Bid[] MOL;
    ActivationRequest[] ARL;
    FlexibilityDP[] public DPs;
    address payable owner;
    address productID;
    uint256 totalPower;
    uint256 openingDate;
    uint256 closingDate;
    string localization;
    uint256 sum;
    ActivationRequest[] filtered_ARL;

    constructor(
        address payable _owner,
        address _productID,
        uint256 _totalPower,
        uint256 _openingDate,
        uint256 _closingDate,
        string memory _localization
    ) payable {
        owner = _owner;
        productID = _productID;
        totalPower = _totalPower;
        openingDate = _openingDate;
        closingDate = _closingDate;
        localization = _localization;
    }

    /*modifiers*/
    modifier onlyOwner(address _owner) {
        require(_owner == owner, "not owner of CFT");
        _;
    }

    modifier validLocalization(string memory _localization) {
        require(
            (keccak256(abi.encodePacked(_localization))) ==
                (keccak256(abi.encodePacked(localization))) ||
                (keccak256(abi.encodePacked(_localization))) ==
                (keccak256(abi.encodePacked("*"))),
            "not valid localization"
        );
        _;
    }

    modifier validDeliveryDate(uint256 _startOfDelivery) {
        require(
            _startOfDelivery > openingDate && _startOfDelivery < closingDate,
            "not valid date"
        );
        _;
    }

    modifier validBid(address payable _owner) {
        require(_owner != owner, "owner can't bid");
        _;
    }

    modifier validQuantity(uint256 _quantity) {
        require(((_quantity + sumQte()) <= totalPower ) && (_quantity >0), "not valid qte");
        _;
    }

    modifier positiveQte(uint256 _quantity) {
        require((_quantity >0), "not valid qte");
        _;
    }

    /*-------------------*/
    function sumQte() internal returns(uint256){
        sum = 0;
        for(uint i = 0; i< aRs.length; i++){
            sum += ActivationRequest(aRs[i]).getQuantity();  
        }

        return sum;
    }

    function createActivationRequest(
        address payable _owner,
        uint256 _quantity,
        uint256 _startOfDelivery
    ) external payable onlyOwner(_owner) validDeliveryDate(_startOfDelivery) validQuantity(_quantity){
        ActivationRequest newActivationRequest = new ActivationRequest(
            _owner,
            productID,
            _quantity,
            localization,
            _startOfDelivery,
            block.timestamp
        );
        aRs.push(newActivationRequest);
    }

    function createBid(
        address payable _owner,
        string calldata _serviceProvider,
        uint256 _price,
        uint256 _quantity,
        string calldata _localization,
        uint256 _startOfDelivery
    )
        external
        payable
        validBid(_owner)
        validLocalization(_localization)
        validDeliveryDate(_startOfDelivery)
        positiveQte(_quantity)
    {
        Bid newBid = new Bid(
            _owner,
            _serviceProvider,
            _price,
            productID,
            _quantity,
            _localization,
            _startOfDelivery,
            block.timestamp
        );
        bids.push(newBid);
    }

    function getAllARs() external view returns (ActivationRequest[] memory) {
        return aRs;
    }

    function getAllBids() external view returns (Bid[] memory) {
        return bids;
    }

    function getCFTDetails()
        external
        view
        returns (
            address payable,
            address,
            uint256,
            uint256,
            uint256,
            string memory
        )
    {
        return (
            owner,
            productID,
            totalPower,
            openingDate,
            closingDate,
            localization
        );
    }

    function getProductName(address _productAddress) external view returns(string memory){
        return Product(_productAddress).getProductName();
    }

    function getAllDPs() external view returns (FlexibilityDP[] memory) {
        return DPs;
    }

    function setCurrentARL(uint256 _startDP, uint256 _endDP) external payable {
        for (uint256 i = 0; i < aRs.length; i++) {
            if ((ActivationRequest(aRs[i]).getStartOfDelivery() >= _startDP) && (ActivationRequest(aRs[i]).getStartOfDelivery() < _endDP)) {
                ARL.push(aRs[i]);
            }
        }
    }

    function sortBids(Bid[] memory _bids) internal view returns (Bid[] memory) {
        Bid temp;
        for (uint256 k = 0; k < _bids.length - 1; k++) {
            for (uint256 l = k + 1; l < _bids.length; l++) {
                if (Bid(_bids[k]).getPrice() > Bid(_bids[l]).getPrice()) {
                    temp = _bids[k];
                    _bids[k] = _bids[l];
                    _bids[l] = temp;
                }
            }
        }

        return _bids;
    }

    function setCurrentMOL(uint256 _startDP, uint256 _endDP) payable external {
        for (uint256 i = 0; i < bids.length; i++) {
            if ((Bid(bids[i]).getStartOfDelivery() >= _startDP) && (Bid(bids[i]).getStartOfDelivery()  < _endDP)) {
                unsortedBids.push(bids[i]);
            }
        }
        MOL = sortBids(unsortedBids);

    }

    function filter() external payable returns(bool){
        uint256 quantity = 0;
        for (uint i=0; i<ARL.length ; i++){
            if (ActivationRequest(ARL[i]).getQuantity() > quantity){
                filtered_ARL.push(ARL[i]);
            }
            else{
                ActivationRequest(ARL[i]).setStatus();
            }
            quantity = ActivationRequest(ARL[i]).getQuantity();
            
        }

        return true;

    }

    function getFiltered_ARL() external view returns(ActivationRequest[] memory){
        return filtered_ARL;
    }

    function getARL() external view returns(ActivationRequest[] memory){

        return ARL;
    }

    function getMOL() external view returns(Bid[] memory){

        return MOL;
    }

    function createFlexibilityDP() payable external {

        FlexibilityDP newFlexibilityDP = new FlexibilityDP( filtered_ARL, MOL);
        DPs.push(newFlexibilityDP);
    }

}
