# 项目测试
```
//git bash:初始化项目
forge init testUniswapV2flashloan

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
$ forge test  --fork-url https://eth-mainnet.g.alchemy.com/v2/YOU_KEY --match-path test/UniswapV2Flashloan.test.sol -vv
```



# origin readme

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
