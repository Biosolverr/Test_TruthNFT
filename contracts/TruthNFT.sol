// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * TruthNFT
 *
 * Five deliberately different test NFTs for the NFT Truth Layer:
 * 1 - honest / fully consistent
 * 2 - metadata-image contradiction
 * 3 - collection/web-evidence test
 * 4 - ambiguous evidence test
 * 5 - adversarial prompt-injection metadata test
 *
 * Metadata is intentionally hosted off-chain so the GenLayer verifier
 * can test web retrieval and semantic verification.
 */
contract TruthNFT is ERC721URIStorage, Ownable {
    uint256 public constant MAX_TOKEN_ID = 5;

    constructor() ERC721("TruthNFT", "TRUTH") Ownable(msg.sender) {
        // Mint all five test NFTs to the deployer.
        for (uint256 tokenId = 1; tokenId <= MAX_TOKEN_ID; tokenId++) {
            _safeMint(msg.sender, tokenId);
        }
    }

    /**
     * Owner can update a token URI while building adversarial test cases.
     * Remove this function for a more immutable production collection.
     */
    function setTokenURI(uint256 tokenId, string calldata uri) external onlyOwner {
        _setTokenURI(tokenId, uri);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
