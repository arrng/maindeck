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
  let hhMockERC20
  let hhMockERC721

  before(async function () {
    ;[owner, addr1, addr2, addr3, addr4, addr5, treasury, ...addrs] =
      await ethers.getSigners()

    const arrngController = await ethers.getContractFactory("ArrngController")
    hhArrngController = await arrngController.deploy(owner.address)

    const mockERC20 = await ethers.getContractFactory("mockERC20")
    const mockERC721 = await ethers.getContractFactory("mockERC721")
    hhMockERC20 = await mockERC20.deploy()
    hhMockERC721 = await mockERC721.deploy()
  })

  context("ArrngController", function () {
    describe("Admin Functions", function () {
      before(async function () {})

      it("thisDoBeTheENSLog - Non-owner cannot call", async () => {
        await expect(
          hhArrngController.connect(addr1).thisDoBeTheENSLog(addr3.address),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("thisDoBeTheENSLog - Owner can call", async () => {
        expect(await hhArrngController.ensLog()).to.equal(
          ethers.constants.AddressZero,
        )

        await expect(
          hhArrngController.connect(owner).thisDoBeTheENSLog(addr3.address),
        ).to.not.be.reverted

        expect(await hhArrngController.ensLog()).to.equal(addr3.address)
      })

      it("thisDoBeTheSmallestTreasureChest - Non-owner cannot call", async () => {
        await expect(
          hhArrngController
            .connect(addr1)
            .thisDoBeTheSmallestTreasureChest(1000000000000000),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("thisDoBeTheSmallestTreasureChest - Owner can call", async () => {
        expect(await hhArrngController.minimumNativeToken()).to.equal(0)

        await expect(
          hhArrngController
            .connect(owner)
            .thisDoBeTheSmallestTreasureChest(1000000000000000),
        ).to.not.be.reverted

        expect(await hhArrngController.minimumNativeToken()).to.equal(
          1000000000000000,
        )
      })

      it("thisDoBeTheMostNumbersYeCanGet - Non-owner cannot call", async () => {
        await expect(
          hhArrngController.connect(addr1).thisDoBeTheMostNumbersYeCanGet(5000),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("thisDoBeTheMostNumbersYeCanGet - Owner can call", async () => {
        expect(await hhArrngController.maximumNumberOfNumbers()).to.equal(10000)

        await expect(
          hhArrngController.connect(owner).thisDoBeTheMostNumbersYeCanGet(5000),
        ).to.not.be.reverted

        expect(await hhArrngController.maximumNumberOfNumbers()).to.equal(5000)
      })

      it("thisDoBeTheFirstMate - Non-owner cannot call", async () => {
        await expect(
          hhArrngController.connect(addr1).thisDoBeTheFirstMate(addr2.address),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("thisDoBeTheFirstMate - Owner can call", async () => {
        expect(await hhArrngController.firstMate()).to.equal(
          ethers.constants.AddressZero,
        )

        await expect(
          hhArrngController.connect(owner).thisDoBeTheFirstMate(addr2.address),
        ).to.not.be.reverted

        expect(await hhArrngController.firstMate()).to.equal(addr2.address)
      })

      it("thisDoBeTheStrongbox - Non-owner cannot call", async () => {
        await expect(
          hhArrngController.connect(addr1).thisDoBeTheStrongbox(addr4.address),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("thisDoBeTheStrongbox - Owner can call", async () => {
        expect(await hhArrngController.strongbox()).to.equal(
          ethers.constants.AddressZero,
        )

        await expect(
          hhArrngController.connect(owner).thisDoBeTheStrongbox(addr4.address),
        ).to.not.be.reverted

        expect(await hhArrngController.strongbox()).to.equal(addr4.address)
      })
    })

    describe("Finance Functions", function () {
      before(async function () {
        await hhMockERC20.connect(owner).mint(hhArrngController.address, 1000)
        await hhMockERC721.connect(owner).safeMint20(owner.address)
        await hhMockERC721
          .connect(owner)
          ["safeTransferFrom(address,address,uint256)"](
            owner.address,
            hhArrngController.address,
            0,
          )
        await hhMockERC721
          .connect(owner)
          ["safeTransferFrom(address,address,uint256)"](
            owner.address,
            hhArrngController.address,
            1,
          )
        await hhMockERC721
          .connect(owner)
          ["safeTransferFrom(address,address,uint256)"](
            owner.address,
            hhArrngController.address,
            2,
          )
      })

      it("getGold - Non-owner cannot call", async () => {
        await expect(
          hhArrngController.connect(addr1).getGold(0),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("getGold - Owner can call", async () => {
        await expect(hhArrngController.connect(owner).getGold(0)).to.not.be
          .reverted
      })

      it("getDubloons - Non-owner cannot call", async () => {
        await expect(
          hhArrngController.connect(addr1).getDubloons(hhMockERC20.address, 1),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("getDubloons - Owner can call", async () => {
        await expect(
          hhArrngController.connect(owner).getDubloons(hhMockERC20.address, 1),
        ).to.not.be.reverted
      })

      it("getGems - Non-owner cannot call", async () => {
        await expect(
          hhArrngController
            .connect(addr1)
            .getGems(hhMockERC721.address, [0, 1, 2]),
        ).to.be.revertedWith("Ownable: caller is not the owner")
      })

      it("getGems - Owner can call", async () => {
        await expect(
          hhArrngController
            .connect(owner)
            .getGems(hhMockERC721.address, [0, 1, 2]),
        ).to.not.be.reverted
      })
    })

    describe("Error States", function () {
      before(async function () {})

      it("Cannot get random numbers with insufficient native token", async () => {
        await expect(
          hhArrngController.connect(addr1)["requestRandomWords(uint256)"](2),
        ).to.be.revertedWith(
          "Insufficient native token for gas, minimum is 1000000000000000. You may need more depending on the number of numbers requested and prevailing gas cost. All excess refunded, less txn fee.",
        )
      })
    })
  })
})
