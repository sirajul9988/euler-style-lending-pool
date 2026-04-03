# Multi-Asset Lending Pool (Euler-style)

A professional-grade DeFi primitive for decentralized credit markets. This repository implements a "Global Liquidity" model where users can supply any supported asset to earn interest and borrow against it. It uses a specialized "Sub-account" architecture, allowing users to isolate risks between different positions within the same wallet.

## Core Features
* **Reactive Interest Rates:** Rates adjust dynamically based on the utilization ratio ($U$) of the pool.
* **Risk-Adjusted Borrowing:** Implements "Collateral Factors" to determine how much can be borrowed against specific assets.
* **EIP-4626 Integration:** The pool functions as a standardized vault, making it instantly compatible with yield aggregators.
* **Flat Architecture:** Single-directory layout for the Controller, Asset Vaults, and Risk Manager.



## Logic Flow
1. **Supply:** User deposits USDC. The pool mints `eUSDC` (Euler-style receipt tokens).
2. **Borrow:** User uses `eUSDC` as collateral to borrow ETH.
3. **Interest:** Borrowers pay interest, which is distributed to suppliers via the increasing value of `eAsset` tokens.
4. **Liquidation:** If a user's collateral value falls below the required margin, their position is eligible for liquidation.

## Setup
1. `npm install`
2. Deploy `LendingController.sol` and individual `AssetVault.sol` instances.
