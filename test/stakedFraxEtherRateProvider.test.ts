import { ethers } from 'hardhat';
import { expect } from 'chai';
import { Contract } from 'ethers';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/dist/src/signer-with-address';


describe('local network: staked frax Ether rate provider', function() {
    let fraxEther: Contract;
    let stakedFraxEther: Contract;
    let stakedFraxEtherRateProvider: Contract;

    before('setup eoas', async () => {
        console.log('Starting test from block:', await ethers.provider.getBlockNumber())
    })

    beforeEach('deploy mocks & rate provider', async () =>{
        const FraxEther = await ethers.getContractFactory("MockFraxEther")
        fraxEther = await FraxEther.deploy()

        const StakedFraxEther = await ethers.getContractFactory('MockStakedFraxEther');
        stakedFraxEther = await StakedFraxEther.deploy(fraxEther.address, "Staked Frax Ether", "sfrxeth");

        const StakedFraxEtherRateProvider = await ethers.getContractFactory('StakedFraxEtherRateProvider');
        stakedFraxEtherRateProvider = await StakedFraxEtherRateProvider.deploy(stakedFraxEther.address);
    })

    it('returns rate from stakedFraxEther', async () => {
        expect(await stakedFraxEther.pricePerShare()).to.equal(ethers.utils.parseUnits('1', 18));
    })
    it('can set price per share', async () => {
        await stakedFraxEther.setPricePerShare(ethers.utils.parseUnits('2', 18))
        expect(await stakedFraxEther.pricePerShare()).to.equal(ethers.utils.parseUnits('2', 18));
    })
    it('gets rate from rateProvider',async () => {
        expect(await stakedFraxEtherRateProvider.getRate()).to.equal(ethers.utils.parseUnits('1', 18));
    })
    it('gets correct rate from rateProvider after underlying rate update',async () => {
        await stakedFraxEther.setPricePerShare(ethers.utils.parseUnits('2', 18));
        expect(await stakedFraxEtherRateProvider.getRate()).to.equal(ethers.utils.parseUnits('2', 18));
    })
})