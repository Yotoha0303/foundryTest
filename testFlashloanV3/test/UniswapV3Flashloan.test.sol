// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import "../src/UniswapV3Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract UniswapV3FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);

    UniswapV3Flashloan private flashloan;

    function setUp() public {
        vm.createSelectFork(vm.envString("FORK_URL"));

        flashloan = new UniswapV3Flashloan();
    }

    function testFlashloan() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);

        uint balBefore = weth.balanceOf(address(flashloan));
        console.logUint(balBefore);

        uint amountToBorrow = 1 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    function testFlashloanFail() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e17);

        uint amountToBorrow = 100 * 1e18;
        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }
}
