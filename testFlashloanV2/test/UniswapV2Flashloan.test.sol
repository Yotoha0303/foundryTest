// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/UniswapV2Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract UniswapV2FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);
    UniswapV2Flashloan private flashloan;

    function setUp() public {
        vm.createSelectFork(vm.envString("FORK_URL")); // 启动主网 fork

        flashloan = new UniswapV2Flashloan();
    }

    function testFlashloan() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);

        uint amountToBorrow = 100 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    function testFlashloanFail() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 3e17);

        uint amountToBorrow = 100 * 1e18;

        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }

    receive() external payable {}
}
