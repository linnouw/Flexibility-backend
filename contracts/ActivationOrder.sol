// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bid.sol";
import "./ActivationRequest.sol";

contract ActivationOrder{
    
    Bid bid;
    ActivationRequest AR;
    uint256 qte;
    
    constructor(Bid _bid, ActivationRequest _AR, uint256 _qte){
        bid = _bid;
        AR = _AR;
        qte = _qte;
    }

    /*modifiers-------------*/
    
    modifier onlyOwner() {
        require(msg.sender == ActivationRequest(AR).getOwner(), "not valid");
        _;
    }
    /*----------------------*/

    function getAllAODetails() public view returns(Bid, ActivationRequest, uint256){
        return(bid, AR, qte);
    }

    function acceptOrder() public returns(bool) {        
        ActivationRequest(AR).setStatus(3);
        //transfer NFT
        return true;
    }

    function rejectOrder() public returns(bool){
        ActivationRequest(AR).setStatus(4);
        return true;
    }
}