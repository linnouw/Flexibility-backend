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
        string tokenURI;
    }

    function mintToken(address recipient, string memory tokenURI) public {
        _safeMint(recipient, tokenId);
        ownershipRecord[recipient].push(tokenMetadata(tokenId, block.timestamp, tokenURI));

        tokenId = tokenId + 1;
    }
}    
