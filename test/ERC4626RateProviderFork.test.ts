import { ethers } from 'hardhat';
import { expect } from 'chai';
import { Contract } from 'ethers';

describe('mainnet fork staked frax Ether rate provider', function() {
    let stakedFraxEtherRateProvider: Contract;

    before('setup', async () => {
        console.log('Starting test from block:', await ethers.provider.getBlockNumber())
    })

    beforeEach('deploy rate provider', async () =>{
        // mainnet fork from block 15868474
        // returns 1001216513304948175 as per the upper block
        const StakedFraxEtherRateProvider = await ethers.getContractFactory('ERC4626RateProvider');
        stakedFraxEtherRateProvider = await StakedFraxEtherRateProvider.deploy("0xac3E018457B222d93114458476f3E3416Abbe38F");
    })

    it('returns rate from stakedFraxEther', async () => {
        expect(await stakedFraxEtherRateProvider.getRate()).to.equal(ethers.BigNumber.from("1001216513304948175"));
    })
    it('checks decimals are the same',async () => {
        expect(await stakedFraxEtherRateProvider.vaultDecimals()).to.equal(18);
    })
})