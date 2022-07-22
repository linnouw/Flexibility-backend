// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ActivationRequest.sol";
import "./Bid.sol";
import "./FlexibilityDP.sol";

contract CFT {
    ActivationRequest[] public aRs;
    Bid[] public bids;
    Bid[] public unsortedBids;
    Bid[] public MOL;
    ActivationRequest[] public ARL;
    FlexibilityDP[] public DPs;
    address payable owner;
    address productID;
    uint256 totalPower;
    uint256 openingDate;
    uint256 closingDate;
    string localization;

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

    /*-------------------*/

    function createActivationRequest(
        address payable _owner,
        uint256 _quantity,
        uint256 _startOfDelivery
    ) external payable onlyOwner(_owner) validDeliveryDate(_startOfDelivery) {
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

    function getAllDPs() external view returns (FlexibilityDP[] memory) {
        return DPs;
    }

    function setCurrentARL(uint256 _currentDP) internal returns (bool) {
        for (uint256 i = 0; i < aRs.length; i++) {
            if (ActivationRequest(aRs[i]).getCreatedAt() >= _currentDP) {
                ARL.push(aRs[i]);
            }
        }

        return true;
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

    function setCurrentMOL(uint256 _currentDP) internal returns (bool) {
        for (uint256 i = 0; i < bids.length; i++) {
            if (Bid(bids[i]).getCreatedAt() > _currentDP) {
                unsortedBids.push(bids[i]);
            }
        }
        MOL = sortBids(unsortedBids);

        return true;
    }

    function createFlexibilityDP(uint256 _currentDP) external returns (bool) {
        setCurrentARL(_currentDP);
        setCurrentMOL(_currentDP);
        FlexibilityDP newFlexibilityDP = new FlexibilityDP(
            ARL,
            MOL,
            _currentDP
        );
        DPs.push(newFlexibilityDP);

        return true;
    }

    function getARL() external view returns (ActivationRequest[] memory) {
        return ARL;
    }

    function getMOL() external view returns (Bid[] memory) {
        return MOL;
    }
}
