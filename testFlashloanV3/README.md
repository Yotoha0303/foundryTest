## UniswapV3 Flashloan 操作
```
//git bash:初始化项目
forge init testUniswapV3flashloan

1、写入合约
2、写入测试类

//git bash:进行测试
forge compile

//git bash:创建.env
touch .env

//在.env中添加,用于模拟交易测试的网络或者alchemy进行模拟测试（测试网不行，注意选择合适的链进行模拟）
FORK_URL=https://eth.llamarpc.com
# 只能够使用真实环境进行模拟（如测试网不行）
FORK_TESTNET_URL=https://eth-mainnet.g.alchemy.com/v2/YOU_KEY

//在测试用的sol文件中，构造函数下添加使用模拟用的网络
vm.createSelectFork(vm.envString("FORK_URL"));

//git bash:启动测试
forge test -vv

//git bash:不通过在文件中写入配置地址的方式模拟测试合约
$ forge test  --fork-url https://eth-mainnet.g.alchemy.com/v2/YOU_KEY --match-path test/UniswapV3Flashloan.test.sol -vv
```

## UniswapV3 Flashloan测试总结
1、在项目测试中，并未考虑到配置相关的问题，如FORK_URL。
应该及时的检查模拟测试用网络是否出现错误，以及其他配置问题。

2、对项目原理不够了解，导致在项目测试上逻辑不连贯。
