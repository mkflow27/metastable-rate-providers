// SPDX-FileCopyrightText: 2021 Lido <info@lido.fi>

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @title contract returning amount of assets that the Vault would exchange for the amount of shares provided
 * @dev a interface for particular ERC4626 Vault functions. The `convertToAssets` function
 * is the "average user's" exchange rate of shares to be deposited into the vault and
 * the amount of assets received in return
 */
interface IERC4626 {
    /**
     * @notice Get amount of assets for a shares deposited
     * @return Amount of assets for shares deposited
     */
    function convertToAssets(uint256) external view returns (uint256);

    /**
     * @notice Get amount of decimals of the ERC4626 Vault
     * @return Amount of decimals on the Vault
     */
    function decimals() external view returns (uint256);
}
