// // SPDX-License-Identifier: SEE LICENSE IN LICENSE
// pragma solidity >=0.4.0;

// import { Test } from "forge-std/Test.sol";
// import { DeployUniswapV2 } from "../script/deployUniswapV2.s.sol";
// import { IUniswapV2Factory } from "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
// import { IUniswapV2Router02 } from "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
// import { IUniswapV2Router01 } from "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";
// import { WETH } from "../lib/solmate/src/tokens/WETH.sol";
// import {BeeToken} from "../src/BeeToken.sol";

// contract uniswapV2Test is Test {

//     IUniswapV2Factory factory = IUniswapV2Factory(0xC11c1A6DB83cB88176D4777F09474EB6c45E868D);
//     WETH deployedWeth = WETH(payable(0x36c95d43B9Ce20e90DDE7EAfD1ba749f1D578B7c));
//     IUniswapV2Router02 router = IUniswapV2Router02(0x80b3C5171C7eB639178e705ef36083dA728eA84f);

//     function setUp() public {
//         DeployUniswapV2 deployer = new DeployUniswapV2();
//         deployer.run();
//     }

//     function testUniswapV2Factory() public view {
//         assert(factory.feeToSetter() != address(0));
//     }

//     function testWrappedEther() public view {
//         assert(abi.encode(deployedWeth.name()).length > 0);
//     }

//     function testDeployedRouter() public view {
//         assert(router.WETH() != address(0));
//     }

//     // function testAddLiquidity() public {
//     //     BeeToken beeToken = new BeeToken();

//     //     beeToken.approve(address(router), type(uint).max);

//     //     IUniswapV2Router01(router).addLiquidityETH{value:1 ether}(
//     //         address(beeToken),
//     //         beeToken.balanceOf(address(this)),
//     //         0,
//     //         0,
//     //         address(this),
//     //         block.timestamp + 1000
//     //     );

//     // }
// }