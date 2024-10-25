// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.4.0;

import { Script } from "forge-std/Script.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { WETH } from "../lib/solmate/src/tokens/WETH.sol";

contract DeployUniswapV2 is Script, StdCheats {

    function run() public {
        deployCodeTo(
            "UniswapV2Factory.sol:UniswapV2Factory",
            abi.encode(msg.sender),
            0xC11c1A6DB83cB88176D4777F09474EB6c45E868D
        );

        deployCodeTo(
            "WETH.sol:WETH",
            0x36c95d43B9Ce20e90DDE7EAfD1ba749f1D578B7c
        );

        deployCodeTo(
            "UniswapV2Router02.sol:UniswapV2Router02",
            abi.encode(0xC11c1A6DB83cB88176D4777F09474EB6c45E868D, 0x36c95d43B9Ce20e90DDE7EAfD1ba749f1D578B7c),
            0x80b3C5171C7eB639178e705ef36083dA728eA84f
        );
    }

}