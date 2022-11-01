// SPDX-License-Identifier: MIT

pragma solidity^0.8.4;

import "./interfaces/IStakedFraxEther.sol";
import "./interfaces/IRateProvider.sol";

/**
 * @title A rate provider contract used to return the staked frax ether <> frax ether exchange rate
 * @dev How much frxETH is 1E18 sfrxETH worth
 */
contract StakedFraxEtherRateProvider is IRateProvider {
    IStakedFraxEther public immutable stakedFraxEther;

    constructor(IStakedFraxEther _stakedFraxEther) {
        stakedFraxEther = _stakedFraxEther;
    }

    /**
     *@return How much frxETH is 1E18 sfrxETH worth
     */
    function getRate() external view override returns(uint256) {
        return stakedFraxEther.pricePerShare();
    }
}