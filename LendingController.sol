// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./AssetVault.sol";

contract LendingController is Ownable {
    mapping(address => address) public vaults; // Token -> Vault
    mapping(address => mapping(address => uint256)) public userBorrows;

    event MarketAdded(address indexed token, address indexed vault);

    constructor() Ownable(msg.sender) {}

    function addMarket(address _token, string memory _name, string memory _symbol) external onlyOwner {
        AssetVault newVault = new AssetVault(IERC20(_token), _name, _symbol);
        vaults[_token] = address(newVault);
        emit MarketAdded(_token, address(newVault));
    }

    function borrow(address _token, uint256 _amount) external {
        address vaultAddr = vaults[_token];
        require(vaultAddr != address(0), "Market not found");
        
        // In production, check collateral value across all user's supplied vaults here
        AssetVault(vaultAddr).recordBorrow(_amount);
        IERC20(_token).transfer(msg.sender, _amount);
        
        userBorrows[msg.sender][_token] += _amount;
    }
}
