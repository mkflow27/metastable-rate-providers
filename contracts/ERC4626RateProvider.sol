// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./interfaces/IRateProvider.sol";
import "./interfaces/IERC4626.sol";

/**
 * @title Generic ERC4626 Rate Provider
 * @notice Returns value of 1 share in terms of the Vault's underlying asset
 */
contract ERC4626RateProvider is IRateProvider {
    IERC4626 public immutable vault;
    uint256 public immutable vaultDecimals;

    // calling the ERC4626's `decimals` function to ensure
    // `getRate` only relies on the EIP4626's recommendation of
    // equalizing vault's and underlying token's decimals
    constructor(IERC4626 _vault) {
        vault = _vault;
        vaultDecimals = vault.decimals();
    }

    /**
     * @return returns the amount of assets returned for 1 share deposited
     * @notice Exchange rate for 1 share deposited
     * @dev This function takes into account the ERC4626 vault's possibility
     * of having flexible `decimals`
     */
    function getRate() external view override returns (uint256) {
        return vault.convertToAssets(10**vaultDecimals);
    }
}
