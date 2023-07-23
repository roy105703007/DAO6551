// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/DAO6551.sol";
import "../src/DAO6551Implement.sol";
import "reference/src/interfaces/IERC6551Registry.sol";
import "../src/SBTofRoleA.sol";
import "../src/SBTofRoleB.sol";
import "../src/SBTofRoleC.sol";

contract DeployScript is Script {
    IERC6551Registry gnosisRegistry =
        IERC6551Registry(0xC01EE8D00Fe06077dBE1314B0E180256F318d51f);

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        SBTofRoleA sbta = new SBTofRoleA();
        SBTofRoleB sbtb = new SBTofRoleB();
        SBTofRoleC sbtc = new SBTofRoleC();

        DAO6551Implement dao6551Implementation = new DAO6551Implement();
        DAO6551 dao6551 = new DAO6551(
            address(dao6551Implementation),
            address(gnosisRegistry),
            1000,
            1,
            address(sbta),
            address(sbtb),
            address(sbtc)
        );
        sbta.transferOwnership(address(dao6551));

        vm.stopBroadcast();
    }
}
