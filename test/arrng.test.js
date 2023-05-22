const { ethers } = require("hardhat")
const { expect } = require("chai")

describe("Arng Controller", function () {
  let owner
  let addr1
  let addr2
  let addr3
  let addr4
  let addr5
  let treasury

  let hhArrngController

  before(async function () {
    ;[owner, addr1, addr2, addr3, addr4, addr5, treasury, ...addrs] =
      await ethers.getSigners()

    const arrngController = await ethers.getContractFactory("ArrngController")
    hhArrngController = await arrngController.deploy(owner.address)
  })

  context("ArrngController", function () {
    describe("Admin Functions", function () {
      before(async function () {})

      it("Owner can set min native token", async () => {
        await expect(
          hhArrngController
            .connect(owner)
            .thisDoBeTheSmallestTreasureChest(1000000000000000),
        ).to.not.be.reverted
      })
    })

    describe("Error States", function () {
      before(async function () {})

      it("Cannot get random numbers with insufficient native token", async () => {
        await expect(
          hhArrngController.connect(addr1)["requestRandomWords(uint256)"](2),
        ).to.be.revertedWith(
          "Insufficient native token for gas, minimum is 1000000000000000. You may need more depending on the number of numbers requested. All excess refunded, less txn fee.",
        )
      })
    })
  })
})
