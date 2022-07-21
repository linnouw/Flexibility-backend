// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bid.sol";
import "./ActivationRequest.sol";

contract ActivationOrder{
    
    Bid bid;
    ActivationRequest AR;
    uint256 qte;
    
    constructor(Bid _bid, ActivationRequest _AR, uint256 _qte) public{
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

    function acceptOrder() public onlyOwner returns() {        
        ActivationRequest(AR).setStatus(3);
        //transfer NFT
    }

    function rejectOrder() public onlyOwner{
        ActivationRequest(AR).setStatus(4);
    }
}