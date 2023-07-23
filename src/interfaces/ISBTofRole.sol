// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ISBTofRole {
    function safeMint(address to) external;

    function burn(uint256 tokenId) external;
}
