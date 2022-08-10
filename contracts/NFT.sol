// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is Ownable, ERC721("Bid NFT","BNFT"){

    uint tokenId;

    mapping (address => tokenMetadata[]) public ownershipRecord;

    struct tokenMetadata {
        uint256 tokenId;
        uint256 timestamp;
        address tokenURI;
    }

    function mintToken(address recipient, address bidAddress) public {
        _safeMint(recipient, tokenId);
        ownershipRecord[recipient].push(tokenMetadata(tokenId, block.timestamp, bidAddress));

        tokenId = tokenId + 1;
    }
}    
