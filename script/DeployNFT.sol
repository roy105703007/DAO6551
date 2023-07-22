// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/DAO6551.sol";
import "../src/DAO6551Implement.sol";
import "reference/src/interfaces/IERC6551Registry.sol";

contract DeployScript is Script {
    IERC6551Registry gnosisRegistry =
        IERC6551Registry(0x02101dfB77FDE026414827Fdc604ddAF224F0921);

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DAO6551Implement dao6551Implementation = new DAO6551Implement();
        DAO6551 dao6551 = new DAO6551(
            address(dao6551Implementation),
            address(gnosisRegistry),
            1000,
            1
        );

        vm.stopBroadcast();
    }
}
