// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

//声明UniswapV2闪电贷回调接口
interface IUniswapV2Callee {
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external;
}

//声明UniswapV2闪电贷合约
contract UniswapV2Flashloan is IUniswapV2Callee {
    address private constant UNISWAP_V2_FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    IUniswapV2Factory private constant factory =
        IUniswapV2Factory(UNISWAP_V2_FACTORY);

    IERC20 private constant weth = IERC20(WETH);

    IUniswapV2Pair private immutable pair;

    constructor() {
        address _pair = factory.getPair(DAI, WETH);
        require(_pair != address(0), "DAI-WETH pair not found");
        pair = IUniswapV2Pair(_pair);
    }

    //闪电贷函数
    function flashloan(uint wethAmount) external {
        // calldata长度大于1才能触发闪电贷回调函数
        bytes memory data = abi.encode(WETH, wethAmount);

        // amount0Out是要借的DAI, amount1Out是要借的WETH
        pair.swap(0, wethAmount, address(this), data);
    }

    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        address token0 = IUniswapV2Pair(msg.sender).token0(); //获取token0的地址
        address token1 = IUniswapV2Pair(msg.sender).token1(); //获取token1的地址
        assert(msg.sender == factory.getPair(token0, token1)); //确认提供者是V2 Pair

        //解码calldata
        (address tokenBorrow, uint256 wethAmount) = abi.decode(
            data,
            (address, uint256)
        );

        require(tokenBorrow == WETH, "token borrow!=WETH");

        //计算flashload费用
        //fee / (amount + fee) = 3/1000
        //向上取整数
        uint fee = (amount1 * 3) / 997 + 1;
        uint amountToRepay = amount1 + fee;

        //归还闪电贷
        // weth.transfer(address(pair), amountToRepay);

        require(
            weth.balanceOf(address(this)) >= amountToRepay,
            "Insufficient WETH for repayment"
        );

        weth.transfer(address(pair), amountToRepay);
    }
}
