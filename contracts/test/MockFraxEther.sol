// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity^0.8.4;

contract MockFraxEther is ERC20 {

    constructor() ERC20("MockFraxEther", "frxEth"){
        _mint(msg.sender, 1e18);
    }
}