// SPDX-License-Identifier: MIT

pragma solidity^0.8.4;

/**
 * @title Interface for Frax's Staked Frax Ether
 * @notice Use this interface to fetch sfrxEth <> Eth exchange rate
 * @dev the implementation contract returns a arbitrarily set value
 */
interface IStakedFraxEther {
    /**
     * @notice Price per 1 Ether
     * @return Price of 1 sfrxEth in terms of 1 Ether
     */
    function pricePerShare() external view returns (uint256);
}