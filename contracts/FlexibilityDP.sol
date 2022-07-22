// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bid.sol";
import "./ActivationRequest.sol";
import "./ActivationOrder.sol";

contract FlexibilityDP {
    ActivationRequest[] ARL;
    Bid[] MOL;
    uint256 currentDP;
    ActivationOrder[] AOs;

    constructor(
        ActivationRequest[] memory _ARL,
        Bid[] memory _MOL,
        uint256 _currentDP
    ) {
        ARL = _ARL;
        MOL = _MOL;
        currentDP = _currentDP;
    }

    function getARL() external view returns (ActivationRequest[] memory) {
        return ARL;
    }

    function getMOL() external view returns (Bid[] memory) {
        return MOL;
    }

    function pop_ARL(uint256 _index) internal returns (ActivationRequest) {
        require((_index >= 0) && (_index < ARL.length), "not valid");
        ActivationRequest element = ARL[_index];
        for (uint256 i = _index; i < ARL.length - 1; i++) {
            ARL[i] = ARL[i + 1];
        }

        ARL.pop();

        return element;
    }

    function pop_MOL(uint256 _index) internal returns (Bid) {
        require((_index >= 0) && (_index < MOL.length), "not valid");
        Bid element = MOL[_index];
        for (uint256 i = _index; i < MOL.length - 1; i++) {
            MOL[i] = MOL[i + 1];
        }
        MOL.pop();

        return element;
    }

    function insert_ARL(uint256 _index, ActivationRequest _AR)
        internal
        returns (bool)
    {
        ActivationRequest element = ARL[_index];
        ARL[_index] = _AR;
        ARL.push(ARL[ARL.length - 1]);
        uint256 i = ARL.length - 1;
        while (i != _index + 1) {
            ARL[i] = ARL[i - 1];
        }
        ARL[_index + 1] = element;

        return true;
    }

    function insert_MOL(uint256 _index, Bid _bid) internal returns (bool) {
        Bid element = MOL[_index];
        MOL[_index] = _bid;
        MOL.push(MOL[MOL.length - 1]);
        uint256 i = MOL.length - 1;
        while (i != _index + 1) {
            MOL[i] = MOL[i - 1];
        }
        MOL[_index + 1] = element;

        return true;
    }

    function createActivationOrder(
        Bid _bid,
        ActivationRequest _AR,
        uint256 _qte
    ) internal {
        ActivationOrder newAO = new ActivationOrder(_bid, _AR, _qte);
        AOs.push(newAO);
    }

    function getAllActivationOrders()
        external
        view
        returns (ActivationOrder[] memory)
    {
        return AOs;
    }

    function dispatch() external returns (bool) {
        uint256 previousQte = 0;
        uint256 initialQte;
        ActivationRequest currentAR;
        Bid currentBid;
        uint256 newBidQuantity;
        uint256 newARQuantity;
        uint256 currentAR_qte;
        ActivationOrder newAO;

        while ((MOL.length != 0) && (ARL.length != 0)) {
            currentAR = pop_ARL(0);
            currentBid = pop_MOL(0);
            currentAR_qte = ActivationRequest(currentAR).getQuantity();
            initialQte = currentAR_qte;

            if ((previousQte >= 0) && (currentAR_qte < previousQte)) {
                ActivationRequest(currentAR).setStatus(1);
            } else if (Bid(currentBid).getQuantity() >= currentAR_qte) {
                newBidQuantity = Bid(currentBid).getQuantity() - currentAR_qte;
                Bid(currentBid).setQuantity(newBidQuantity);
                insert_MOL(0, currentBid);
                //createActivationOrder(currentBid, currentAR , currentAR_qte);
                newAO = new ActivationOrder(
                    currentBid,
                    currentAR,
                    currentAR_qte
                );
                AOs.push(newAO);
                if (currentAR_qte == 0) {
                    ActivationRequest(currentAR).setStatus(2);
                }
            } else if (Bid(currentBid).getQuantity() < currentAR_qte) {
                newARQuantity = currentAR_qte - Bid(currentBid).getQuantity();
                ActivationRequest(currentAR).setQuantity(newARQuantity);
                insert_ARL(0, currentAR);
                //createActivationOrder(currentBid, currentAR, Bid(currentBid).getQuantity());
                newAO = new ActivationOrder(
                    currentBid,
                    currentAR,
                    Bid(currentBid).getQuantity()
                );
                AOs.push(newAO);
            }

            previousQte = initialQte;
        }

        return true;
    }
}
