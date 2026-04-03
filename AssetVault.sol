// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title AssetVault
 * @dev EIP-4626 compliant vault for lending pool assets.
 */
contract AssetVault is ERC4626, Ownable {
    uint256 public totalBorrowed;

    constructor(IERC20 _asset, string memory _name, string memory _symbol) 
        ERC4626(_asset) 
        ERC20(_name, _symbol) 
        Ownable(msg.sender) 
    {}

    /**
     * @dev Simple utilization-based interest rate model.
     */
    function getUtilization() public view returns (uint256) {
        uint256 totalAssets = totalAssets();
        if (totalAssets == 0) return 0;
        return (totalBorrowed * 1e18) / totalAssets;
    }

    function recordBorrow(uint256 _amount) external onlyOwner {
        require(_amount <= maxWithdraw(owner()), "Insufficient liquidity");
        totalBorrowed += _amount;
    }

    function recordRepay(uint256 _amount) external onlyOwner {
        totalBorrowed -= _amount;
    }
}
