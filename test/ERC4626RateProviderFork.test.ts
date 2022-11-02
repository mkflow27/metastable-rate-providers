import { ethers } from 'hardhat';
import { expect } from 'chai';
import { Contract } from 'ethers';

describe('mainnet fork ERC4626 rate provider', function () {
  let erc4626RateProvider: Contract;

  before('setup', async () => {
    console.log('Starting test from block:', await ethers.provider.getBlockNumber());
  });

  beforeEach('deploy rate provider', async () => {
    // mainnet fork from block 15868474
    // returns 1001216513304948175 as per the upper block
    const Erc4626RateProvider = await ethers.getContractFactory('ERC4626RateProvider');
    erc4626RateProvider = await Erc4626RateProvider.deploy(
      '0xac3E018457B222d93114458476f3E3416Abbe38F', // Staked Frax Ether
      '0x5E8422345238F34275888049021821E8E08CAa1f', // Frax Ether
    );
  });

  it('returns rate from stakedFraxEther', async () => {
    expect(await erc4626RateProvider.getRate()).to.equal(ethers.BigNumber.from('1001216513304948175'));
  });
});
