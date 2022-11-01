# <img src="logo.svg" alt="Balancer" height="128px">

# Balancer Metastable Rate Providers

[![CI Status](https://github.com/balancer-labs/metastable-rate-providers/workflows/CI/badge.svg)](https://github.com/balancer-labs/metastable-rate-providers/actions)
[![License](https://img.shields.io/badge/License-GPLv3-green.svg)](https://www.gnu.org/licenses/gpl-3.0)

This repository contains adaptors which provide accurate values of tokens to be used in the Balancer Protocol V2 metastable pools, along with their tests, configuration, and deployment information.

To see how these are used in Balancer V2, see the [Stable Pool package](https://github.com/balancer-labs/balancer-v2-monorepo/tree/master/pkg/pool-stable) in the Balancer V2 monorepo.


## Build and Test

On the project root, run:

For now, please run the mainnet fork test individually

```bash
$ yarn # install all dependencies
$ yarn build # compile all contracts
$ yarn test # run all tests
```

## Licensing

Most of the Solidity source code is licensed under the GNU General Public License Version 3 (GPL v3): see [`LICENSE`](./LICENSE).

## About the staked frax ether rate provider
- A goerli mockimplementation of MockFraxEther can be found at 0x97b267429aD81351F1B2Caf39466D564C72fE6e5
- A goerli mockimplementation of MockStaked FraxEther can be found at 0x36aC1a6919dA11144A22930d3422999D4bB5b566
- A goerli implementation of the staked FraxEther rate provider can be found at 0x936FeA6d4b106A78affc6b8F119Ef955B2Fe0c91


