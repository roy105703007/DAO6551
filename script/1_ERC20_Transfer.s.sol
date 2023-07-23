// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {BatchScript} from "./BatchScript.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @notice A test for Gnosis Safe batching script
/// @dev    GOERLI
contract TestAuthBatch is BatchScript {
    address safe = 0x3064C42517f1799DbEb7e0C60F94Ff415bf11E87;
    address deployer = 0x1dB47D1a06Df36f963af1b086B012bb278071372;

    /// @notice The main script entrypoint
    function run(
        bool send_,
        address tokenAddr,
        address to,
        uint value
    ) external {
        // Start batch
        addToBatch(
            tokenAddr,
            0,
            abi.encodeWithSelector(IERC20.transfer.selector, to, value)
        );

        // Execute batch
        executeBatch(safe, send_);
    }
}
