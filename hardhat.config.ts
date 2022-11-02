import { HardhatUserConfig } from 'hardhat/config';

import '@nomiclabs/hardhat-ethers';
import '@nomiclabs/hardhat-waffle';
import "@nomiclabs/hardhat-etherscan";
//import 'hardhat-local-networks-config-plugin';

const CHAIN_IDS = {
  hardhat: 31337, // chain ID for hardhat testing
};

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.4',
    settings: {
      optimizer: {
        enabled: true,
        runs: 9999,
      },
    },
  },
  etherscan: {
    apiKey: {
      goerli: 'etherscan key'
    }
  },
  networks: {
    hardhat: {
      chainId: CHAIN_IDS.hardhat,
      forking: {
        url: `archival node`,
        blockNumber: 15868474,
      }
    },
    goerli: {
      url: "goerli node",
      accounts: ["pk"],
    }
  }
};

export default config;
