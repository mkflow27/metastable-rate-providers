// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "@balancer-labs/v2-solidity-utils/contracts/math/Math.sol";
import "@balancer-labs/v2-interfaces/contracts/solidity-utils/misc/IERC4626.sol";
import "@balancer-labs/v2-interfaces/contracts/solidity-utils/openzeppelin/IERC20.sol";
import "./interfaces/IERC20Extended.sol";
import "./interfaces/IRateProvider.sol";

/**
 * @title Generic ERC4626 Rate Provider
 * @notice Returns value of 1 share in terms of the Vault's underlying asset
 */
contract ERC4626RateProvider is IRateProvider {
    using Math for uint256;

    uint256 private immutable _rateScaleFactor;
    IERC4626 public immutable wrappedToken;

    // calling the ERC4626's `decimals` function to ensure
    // `getRate` only relies on the EIP4626's recommendation of
    // equalizing vault's and underlying token's decimals
    constructor(IERC4626 _wrappedToken, IERC20Extended _mainToken) {
        uint256 wrappedTokenDecimals = IERC20Extended(address(_wrappedToken)).decimals();
        uint256 mainTokenDecimals = _mainToken.decimals();
        uint256 digitsDifference = Math.add(18, wrappedTokenDecimals).sub(mainTokenDecimals);
        _rateScaleFactor = 10**digitsDifference;
        wrappedToken = _wrappedToken;
    }

    /**
     * @return returns the amount of assets returned for 1 share deposited
     * @notice Exchange rate for 1 share deposited
     * @dev This function takes into account the ERC4626 vault's possibility
     * of having flexible `decimals`
     */
    function getRate() external view override returns (uint256) {
        uint256 assetsPerShare = wrappedToken.convertToAssets(1e18);

        // This function returns a 18 decimal fixed point number
        // assetsPerShare decimals:   18 + main - wrapped
        // _rateScaleFactor decimals: 18 - main + wrapped
        uint256 rate = assetsPerShare.mul(_rateScaleFactor).divDown(1e18);
        return rate;
    }
}
