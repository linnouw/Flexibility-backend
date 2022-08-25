// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./Bid.sol";
import "./ActivationRequest.sol";

contract FlexibilityDP {
    using SafeMath for uint256;
    struct ao{
        address AR_owner;
        address bid_owner;
        uint256 qte;
    }
    // attributes
    ActivationRequest[] ARL;
    Bid[] MOL;
    ao public newAO;
    ao[] AOs;

    // =============================================================
    //                            Deployment
    // =============================================================
    constructor(
        ActivationRequest[] memory _ARL,
        Bid[] memory _MOL
    ) {
        ARL = _ARL;
        MOL = _MOL;
    }

    // ===========================================================================
    //    Reading addresses of activation requests, MOL and activation orders
    // ===========================================================================
    function getARL() external view returns (ActivationRequest[] memory) {
        return ARL;
    }

    function getMOL() external view returns (Bid[] memory) {
        return MOL;
    }

    function getAllActivationOrders()
        external
        view
        returns (ao[] memory)
    {
        return AOs;
    }

    // ===========================================================================
    //                            Bid Matching algorithm
    // ===========================================================================
    // function to delete element from ARL at index ( ARL[index] will be deleted )
    // INTERNAL FUNCTION USED IN DISPATCH() METHOD
    function pop_ARL(uint256 _index) internal returns (ActivationRequest) {
        assert((_index >= 0) && (_index < ARL.length));
        ActivationRequest element = ARL[_index];
        for (uint256 i = _index; i < ARL.length - 1; i++) {
            ARL[i] = ARL[i + 1];
        }

        ARL.pop();

        return element;
    }

    // function to delete element from MOL at index ( MOL[index] will be deleted )
    // INTERNAL FUNCTION USED IN DISPATCH() METHOD
    function pop_MOL(uint256 _index) internal returns (Bid) {
        assert((_index >= 0) && (_index < MOL.length));
        Bid element = MOL[_index];
        for (uint256 i = _index; i < MOL.length - 1; i++) {
            MOL[i] = MOL[i + 1];
        }
        MOL.pop();

        return element;
    }

    // function to insert _AR from ARL at index ( _AR will be inserted at index in ARL )
    // INTERNAL FUNCTION USED IN DISPATCH() METHOD
    function insert_ARL(uint256 _index, ActivationRequest _AR)
        internal
        returns (bool)
    {
        if (ARL.length == 0)
            ARL.push(_AR);
        else{
        ActivationRequest element = ARL[_index];
        ARL[_index] = _AR;
        ARL.push(ARL[ARL.length - 1]);
        uint256 i = ARL.length - 1;
        while (i != _index + 1) {
            ARL[i] = ARL[i - 1];
        }
        ARL[_index + 1] = element;
        }
        return true;
    }

    // function to insert _bid from MOL at index ( _bid will be inserted at index in MOL )
    // INTERNAL FUNCTION USED IN DISPATCH() METHOD
    function insert_MOL(uint256 _index, Bid _bid) internal returns (bool) {
        if (MOL.length == 0)
            MOL.push(_bid);
        else{
        Bid element = MOL[_index];
        MOL[_index] = _bid;
        MOL.push(MOL[MOL.length - 1]);
        uint256 i = MOL.length - 1;
        while (i != _index + 1) {
            MOL[i] = MOL[i - 1];
        }
        MOL[_index + 1] = element;
        }

        return true;
    }

    // function to create activation order
    // INTERNAL FUNCTION USED IN DISPATCH() METHOD
    function createAO(address _AROwner, address _BidOwner, uint256 qte) internal returns(bool){
        newAO.AR_owner = _AROwner;
        newAO.bid_owner = _BidOwner;
        newAO.qte = qte;

        AOs.push(newAO);

        return true;
    }

    // BID MATCHING ALGORITHM
    function dispatch() external payable returns(bool){
        
        while( ( MOL.length != 0 ) && ( ARL.length != 0 ) ){
            Bid currentBid = pop_MOL(0);
            ActivationRequest currentAR = pop_ARL(0);
            uint256 q;

            if ( (ActivationRequest(currentAR).getQuantity()) > (Bid(currentBid).getQuantity()) ){

                ActivationRequest(currentAR).setQuantity( (ActivationRequest(currentAR).getQuantity()).sub(Bid(currentBid).getQuantity()) );
                insert_ARL(0, currentAR);
                q = Bid(currentBid).getQuantity();
            
            }
            else if ( (ActivationRequest(currentAR).getQuantity()) < (Bid(currentBid).getQuantity()) ){

                Bid(currentBid).setQuantity( (Bid(currentBid).getQuantity()).sub(ActivationRequest(currentAR).getQuantity()) );
                insert_MOL(0, currentBid);
                q = ActivationRequest(currentAR).getQuantity();
                ActivationRequest(currentAR).setQuantity(0);

            }
            else{

                q = ActivationRequest(currentAR).getQuantity();
                ActivationRequest(currentAR).setQuantity(0);

            }

            createAO( ActivationRequest(currentAR).getOwner() , Bid(currentBid).getOwner() , q );
            
        }

        return true;
        
    }

}
