// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";

pragma solidity^0.8.4;

contract MockStakedFraxEther is ERC20, IERC4626{

    uint256 public maxDepositAmnt = 2 ** 256 -1;
    uint256 private _currentPricePerShare = 1e18;

    ERC20 private immutable _asset;

    mapping(address => uint256) public sharesPerAccount;

    constructor(
        ERC20 _underlying,
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) {
        _asset = _underlying;
    }

    function deposit(uint256 assets, address receiver) public override returns(uint256) {
        require (assets >0, "Deposit cannot be lower than 0");

        // transfers ERC20 from msg.sender to the Vault
        _asset.transferFrom(msg.sender, address(this), assets);

        // update share tracking
        sharesPerAccount[receiver] += assets;

        // mint shares to msg.sender
        mint(assets, receiver);

        // emit event for tracking purposes
        // emit Deposit(receiver, assets);

        // this are the shares actually since a 1:1 mint is happening.
        return assets;
    }

    function totalAssets() public override view returns(uint256) {
        return _asset.balanceOf(address(this));
    }

    function asset() public override view returns(address) {
        return address(_asset);
    }

    function convertToShares(uint256 assets) public override pure returns (uint256) {
        uint256 shares = assets;
        return shares;
    }

    function convertToAssets(uint256 shares) public override pure returns (uint256) {
        uint256 assets = shares;
        return assets;
    } 

    function maxDeposit(address receiver) external override view returns (uint256 ) {
        uint256 maximumDeposit = receiver != address(0) ? maxDepositAmnt : 0;
        return maximumDeposit;
    }

    function previewDeposit(uint256 assets) external override pure returns (uint256) {
        uint256 sharesToReturnForDepositOperation = assets;
        return sharesToReturnForDepositOperation;
    }

    function maxMint(address receiver) external override view returns (uint256) {
        uint256 maxMintAmount = receiver != address(0) ? maxDepositAmnt : 0;
        return maxMintAmount;
    }

    function previewMint(uint256 shares) public pure override returns (uint256){
        uint256 assetsToReturnForMintOperation = shares;
        return assetsToReturnForMintOperation;
    }

    function mint(uint256 shares, address receiver) public override returns(uint256) {

        // TODO: implement Deposit event
        uint256 amount = previewMint(shares);

        _mint(receiver, amount);
        return amount;
    }

    function maxWithdraw(address owner) external override pure returns (uint256){
        uint256 maxWithdrawAmount = owner != address(0) ? 2 ** 256 -1 : 0;
        return maxWithdrawAmount;
    }

    function previewWithdraw(uint256 assets) public override pure returns(uint256) {
        uint256 sharesWithdrawable = assets;
        return sharesWithdrawable;
    }

    function withdraw(uint256 assets, address receiver, address owner) public override returns(uint256) {
        // burns shares from owner and sends assets of underlying tokens to receiver
        // this implementation is completly unchecked
        _burn(owner, assets);
        _asset.transfer(receiver, assets);
        uint256 shares = assets;
        return shares;
    }

    function maxRedeem(address owner) public override pure returns(uint256) {
        uint256 maxRedeemAmount = owner != address(0) ? 2 ** 256 -1 : 0;
        return maxRedeemAmount;
    }

    function previewRedeem(uint256 shares) public override pure returns(uint256) {
        uint256 assets = shares;
        return assets;
    }

    function redeem(uint256 shares, address receiver, address owner) public override returns(uint256) {
        _burn(owner, shares);
        _asset.transfer(receiver, shares);
        uint256 assets = shares;
        return assets;
    }

    // Staked Frax Ether specific mock implementations
    function pricePerShare() public view returns (uint256) {
        return _currentPricePerShare;
    }

    function setPricePerShare(uint256 price) public {
        _currentPricePerShare = price;
    } 
}


