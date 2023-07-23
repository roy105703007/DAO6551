// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ISBTofRole {
    function mint(address to) external;

    function burn(uint256 tokenId) external;

    function balanceOf(address owner) external view returns (uint256 balance);
}
