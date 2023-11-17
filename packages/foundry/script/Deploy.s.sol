//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/YourContract.sol";
import "./DeployHelpers.s.sol";
import "../contracts/FootyDAO.sol";
import "../contracts/FootyDAOAdapter.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract DeployScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        YourContract yourContract = new YourContract(
            vm.addr(deployerPrivateKey)
        );
        console.logString(
            string.concat(
                "YourContract deployed at: ",
                vm.toString(address(yourContract))
            )
        );

        if(block.chainid != 5) {
            FootyDAO footyDAO = new FootyDAO();
            console.logString(
                string.concat(
                    "FootyDAO deployed at: ",
                    vm.toString(address(footyDAO))
                )
            );
        }else {
            // FootyDAOAdapter footyDAOAdapter = new FootyDAOAdapter(
            //     0x3F9A68fF29B3d86a6928C44dF171A984F6180009
            // );
            // console.logString(
            //     string.concat(
            //         "FootyDAOAdapter deployed at: ",
            //         vm.toString(address(footyDAOAdapter))
            //     )
            // );
            FootyDAOAdapter footyDAOAdapter = FootyDAOAdapter(
                0x1E40E4d7D541294f3621dF3e8E2fA70Db72480aA
            );
            IERC20(0x3F9A68fF29B3d86a6928C44dF171A984F6180009).approve(address(footyDAOAdapter),1000000);
            footyDAOAdapter.joinGame(1,1000000);
        }

        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();
    }

    function test() public {}
}
