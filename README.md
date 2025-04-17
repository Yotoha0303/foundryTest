#### Foundry安装

##### 前置


1、安装[`gcc for windows`](https://sourceforge.net/)   //后续会用到

2、安装[rustup-init](https://www.rust-lang.org/zh-CN/)  //foundry是rust编写的

3、安装[`curl`](https://curl.se/)  //curl下载工具

##### 步骤

1、按照GCC，并且配置bin到环境变量中

2、使用`gcc -v`查看版本号

3、安装Rust

3-1、启动`rustup-init`，在命令行中选择第二项，并且修改`default host triple`的命名，将后缀的"msvc"改成"gnu"，其他则默认

3-2、按回车，进行默认安装

4、使用`rustc -V`查看版本号

5、[如果需要代理]curl代理（注意也要检查git的代理）

如果需要额外配置git的代理，可以参考[`git proxy`配置](https://gist.github.com/evantoli/f8c23a37eb3558ab8765)

```
//每次启动git bash都需要配置一次
//在git bash中，配置curl的代理（将http和https的代理都指向http本地代理）
export http_proxy=http://127.0.0.1:10808
export https_proxy=http://127.0.0.1:10808

//可能会需要用到的git代理
//设置http的代理
git config --global http.proxy http://127.0.0.1:1080
//设置http的代理
git config --global https.proxy https://127.0.0.1:1080

//移除http的代理
git config --global --unset http.proxy
//移除https的代理
git config --global --unset https.proxy
```

6、开始安装

```cl
foundryup

//查看版本
foundryup --version

//成功实例
.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx

 ╔═╗ ╔═╗ ╦ ╦ ╔╗╔ ╔╦╗ ╦═╗ ╦ ╦         Portable and modular toolkit
 ╠╣  ║ ║ ║ ║ ║║║  ║║ ╠╦╝ ╚╦╝    for Ethereum Application Development
 ╚   ╚═╝ ╚═╝ ╝╚╝ ═╩╝ ╩╚═  ╩                 written in Rust.

.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx

Repo       : https://github.com/foundry-rs/foundry
Book       : https://book.getfoundry.sh/
Chat       : https://t.me/foundry_rs/
Support    : https://t.me/foundry_support/
Contribute : https://github.com/foundry-rs/foundry/blob/master/CONTRIBUTING.md

.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx.xOx

foundryup: warning: Make sure no foundry process is running during the install process!
foundryup: installing foundry (version stable, tag stable)
foundryup: downloading forge, cast, anvil, and chisel for stable version
######################################################################## 100.0%
Archive:  /tmp/tmp.MQJJwIsalv/foundry.zip
  inflating: /c/Users/Yotoha/.foundry/versions/stable/anvil.exe
  inflating: /c/Users/Yotoha/.foundry/versions/stable/cast.exe
  inflating: /c/Users/Yotoha/.foundry/versions/stable/chisel.exe
  inflating: /c/Users/Yotoha/.foundry/versions/stable/forge.exe
foundryup: downloading manpages
######################################################################## 100.0%
foundryup: warning: Make sure no foundry process is running during the install process!
foundryup: use - forge 1.0.0-stable (e144b82070 2025-02-13T20:02:16.393821500Z)
foundryup: use - cast 1.0.0-stable (e144b82070 2025-02-13T20:02:16.393821500Z)
foundryup: use - anvil 1.0.0-stable (e144b82070 2025-02-13T20:02:16.393821500Z)
foundryup: use - chisel 1.0.0-stable (e144b82070 2025-02-13T20:02:16.393821500Z)

```

7、检查其他组件是否安装

```
forge --version
cast --version
anvil --version
chisel --version
```

8、开始测试

```
//创建初始化项目counter
forge init counter


forge build

forge test
```

9、工具介绍

forge 类似hardhat，用于编译、部署、测试solidity合约(Rust速度很快)

cast 类似Ethers.js，轻量级交互命令工具

anvil 本地节点
chisel  智能合约模板生成工具
foundry-cli  所有组件的入口点


