const { expect } = require("chai")
const { ethers } = require("hardhat")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe("Dappcord", function () {
  
  const Name = "discord"
  const Symbol = "DC"

  let dappcord
  beforeEach(async() => {
    [deployer, user] = await ethers.getSigners()

    const  Dappcord = await ethers.getContractFactory("Dappcord")
    dappcord = await Dappcord.deploy("discord", "DC") 

    const transaction = await dappcord.connect(deployer).creatChannel("Mercedes", tokens(1))
    await transaction.wait()
  })
  describe("Deployment", () => {
    it ("sets the name", async() => {
      let result = await dappcord.name()
      expect(result).to.equal("discord")
    })
  
    it ("sets the symbol", async() => {
      let result = await dappcord.symbol()
      expect(result).to.equal("DC")
    })
  
    it ("sets the owner", async() => {
      let result = await dappcord.owner()
      expect(result).to.equal(deployer.address)
    })
  })

  describe("creating channels", () => {
    it ("Returns total channels", async() => {
      let result = await dappcord.totalchannels()
      expect(result).to.equal(1)
    })
  })
})
