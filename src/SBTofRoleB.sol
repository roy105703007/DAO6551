// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Base64} from "base64-sol/base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBTofRoleB is ERC721, Ownable {
    using Strings for uint256; // Turns uints into strings
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("SoulBoundToken", "SBT") {}

    function mint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
    }

    function burn(uint256 tokenId) external {
        require(
            ownerOf(tokenId) == msg.sender,
            "Only the owner of the token can burn it."
        );
        _burn(tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256,
        uint256
    ) internal pure override {
        require(
            from == address(0) || to == address(0),
            "This a Soulbound token. It cannot be transferred. It \
        can only be burned by the token owner."
        );
    }

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        string[] memory uriParts = new string[](4);
        string memory balance = "0";
        string memory ethBalanceTwoDecimals = "0";
        uriParts[0] = string("data:application/json;base64,");
        uriParts[1] = string(
            abi.encodePacked(
                '{"name":"DAO6551 #',
                tokenId.toString(),
                '",',
                '"description":"DAO6551 ",',
                '"attributes":[{"trait_type":"Balance","value":"',
                ethBalanceTwoDecimals,
                ' ETH"},{"trait_type":"Status","value":"Exists"}],',
                '"image":"data:image/svg+xml;base64,'
            )
        );

        uriParts[2] = Base64.encode(
            abi.encodePacked(
                '<svg width="1000" height="1000" viewBox="0 0 1000 1000" xmlns="http://www.w3.org/2000/svg">',
                '<rect width="1000" height="1000" fill="hsl(',
                (address(this).balance / 10 ** 17).toString(),
                ', 78%, 56%)"/>',
                '<text x="80" y="276" fill="white" font-family="Helvetica" font-size="70" font-weight="bold">',
                "DAO6551 Role",
                "</text>",
                '<text x="80" y="425" fill="white" font-family="Helvetica" font-size="70" font-weight="bold">',
                ": Developer </text>",
                '<text x="80" y="574" fill="white" font-family="Helvetica" font-size="70" font-weight="bold">',
                "",
                "</text>",
                "</svg>"
            )
        );
        uriParts[3] = string('"}');

        string memory uri = string.concat(
            uriParts[0],
            Base64.encode(
                abi.encodePacked(uriParts[1], uriParts[2], uriParts[3])
            )
        );

        return uri;
    }
}
