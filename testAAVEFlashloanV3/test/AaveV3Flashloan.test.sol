// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/AaveV3Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract AaveV3FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);

    AaveV3Flashloan private flashloan;

    function setUp() public {
        vm.createSelectFork(vm.envString("FORK_TESTNET_URL"));

        flashloan = new AaveV3Flashloan();
    }

    function testFlashloan() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);

        uint amountToBorrow = 100 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    function testFlashloanFail() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 4e16);

        uint amountToBorrow = 100 * 1e18;
        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }
}
