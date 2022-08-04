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
        uint256 tokenURI;
    }

    function mintToken(address recipient, uint256 quantity) public {
        _safeMint(recipient, tokenId);
        ownershipRecord[recipient].push(tokenMetadata(tokenId, block.timestamp, quantity));

        tokenId = tokenId + 1;
    }
}    
