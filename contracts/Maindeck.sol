// SPDX-License-Identifier: BUSL-1.1

/**
 *
 * @title Maindeck.sol. Core contract for arrrrng, the world's first
 * pirate themed multi-chain off-chain RNG generator with full
 * on-chain storage of data and signatures for off-chain verification
 * of on-chain dadadadadad.da...dada..da...dad...dadad...data!
 * Sing it with me!
 *
 * @author arrrrng https://arrrrng.xyz/
 *
 */

pragma solidity 0.8.19;

import {IMaindeck} from "./IMaindeck.sol";
import {IENSReverseRegistrar} from "./ENS/IENSReverseRegistrar.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {IArrrrng} from "./IArrrrng.sol";

contract Maindeck is IMaindeck, Ownable {
  using SafeERC20 for IERC20;

  // Native token required for gas cost to serve RNG:
  uint256 public minimumNativeToken;

  // Address of the oracle:
  address payable public firstMate;

  // Address of the treasury
  address payable public strongbox;

  // Request ID:
  uint256 public skirmishID;

  // Limit on number of returned numbers:
  uint256 public maximumNumberOfNumbers;

  // Address of the ENS reverse registrar to allow assignment of an ENS
  // name to this contract:
  IENSReverseRegistrar public ensLog;

  /**
   *
   * @dev constructor
   *
   * @param captain_: our master/mistress and commander
   *
   */
  constructor(address captain_) {
    _transferOwnership(captain_);
    maximumNumberOfNumbers = 100000;
  }

  /**
   * @dev Walks the plank if called by any account other than the cap'n!
   */
  modifier garrCapnOnly() {
    _checkOwner();
    _;
  }

  /**
   * -------------------------------------------------------------
   * @dev CAPTAIN'S CABIN
   * -------------------------------------------------------------
   */

  /**
   *
   * @dev thisDoBeTheENSLog: set the ENS register address
   *
   * @param ensRegistrar_: ENS Reverse Registrar address
   *
   */
  function thisDoBeTheENSLog(address ensRegistrar_) external garrCapnOnly {
    ensLog = IENSReverseRegistrar(ensRegistrar_);
    emit ENSLogLoggedInTheCaptainsLogOfLogsMatey(ensRegistrar_);
  }

  /**
   *
   * @dev nailColoursToTheMast: used to set reverse record so interactions with this contract
   * are easy to identify
   *
   * @param ensName_: string ENS name
   *
   */
  function nailColoursToTheMast(string memory ensName_) external garrCapnOnly {
    bytes32 ensNameHash = ensLog.setName(ensName_);
    emit ColoursNailedToTheMastMatey(ensName_, ensNameHash);
    (ensName_);
  }

  /**
   *
   * @dev thisDoBeTheSmallestTreasureChest: set a new value of required native token for gas
   *
   * @param minGasFee_: the new minimum native token per call
   *
   */
  function thisDoBeTheSmallestTreasureChest(
    uint256 minGasFee_
  ) external garrCapnOnly {
    minimumNativeToken = minGasFee_;
    emit SmallestTreasureChestSetMatey(minGasFee_);
  }

  /**
   *
   * @dev thisDoBeTheMostNumbersYeCanGet: set a new max number of numbers
   *
   * @param maxNumbersPerTxn_: the new max requested numbers
   *
   */
  function thisDoBeTheMostNumbersYeCanGet(
    uint256 maxNumbersPerTxn_
  ) external garrCapnOnly {
    maximumNumberOfNumbers = maxNumbersPerTxn_;
    emit MostNumbersYeCanGetSetMatey(maxNumbersPerTxn_);
  }

  /**
   *
   * @dev thisDoBeTheFirstMate: set a new oracle address
   *
   * @param oracle_: the new oracle address
   *
   */
  function thisDoBeTheFirstMate(address payable oracle_) external garrCapnOnly {
    firstMate = oracle_;
    emit YarrrOfficerOnDeckMatey(oracle_);
  }

  /**
   *
   * @dev thisDoBeTheStrongbox: set a new treasury address
   *
   * @param treasury_: the new treasury address
   *
   */
  function thisDoBeTheStrongbox(
    address payable treasury_
  ) external garrCapnOnly {
    strongbox = treasury_;
    emit XMarksTheSpot(treasury_);
  }

  /**
   *
   * @dev getGold: cap'n can pull native token to the strong box!
   *
   * @param amount_: amount to withdraw
   *
   */
  function getGold(uint256 amount_) external garrCapnOnly {
    (bool success, ) = strongbox.call{value: amount_}("");
    require(success, "Transfer failed");
  }

  /**
   *
   * @dev getDubloons: cap'n can pull tokens to the strong box!
   *
   * @param amount_: amount to withdraw
   *
   */
  function getDubloons(
    address erc20Address_,
    uint256 amount_
  ) external garrCapnOnly {
    IERC20(erc20Address_).safeTransferFrom(address(this), owner(), amount_);
  }

  /**
   *
   * @dev getGems: Retrieve ERC721s (likely only the ENS
   * associated with this contract)
   *
   * @param erc721Address_: The token contract for the withdrawal
   * @param tokenIDs_: the list of tokenIDs for the withdrawal
   *
   */
  function getGems(
    address erc721Address_,
    uint256[] memory tokenIDs_
  ) external garrCapnOnly {
    for (uint256 i = 0; i < tokenIDs_.length; ) {
      IERC721(erc721Address_).transferFrom(
        address(this),
        owner(),
        tokenIDs_[i]
      );
      unchecked {
        ++i;
      }
    }
  }

  /**
   * -------------------------------------------------------------
   * @dev HOIST THE MAINSAIL!!
   * -------------------------------------------------------------
   */

  /**
   *
   * @dev ahoy: request RNG
   *
   * @param numberOfNumbers_: the amount of numbers to request
   * @param minValue_: the min of the range
   * @param maxValue_: the max of the range
   *
   * @return uniqueID_ : unique ID for this request
   */
  function ahoy(
    uint256 numberOfNumbers_,
    uint256 minValue_,
    uint256 maxValue_
  ) external payable returns (uint256 uniqueID_) {
    skirmishID += 1;

    require(
      msg.value >= minimumNativeToken,
      "ThisDoBeNotEnoughTokenForGasMatey"
    );

    require(numberOfNumbers_ > 0, "GarrrNotEnoughNumbers");

    require(numberOfNumbers_ <= maximumNumberOfNumbers, "GarrrTooManyNumbers");

    (bool success, ) = firstMate.call{value: msg.value}("");
    require(success, "TheTransferWalkedThePlank!(failed)");

    emit ArrrngRequested(
      msg.sender,
      uint96(skirmishID),
      uint64(numberOfNumbers_),
      uint64(minValue_),
      uint64(maxValue_),
      uint64(msg.value)
    );

    return (skirmishID);
  }

  /**
   *
   * @dev landHo: serve RNG
   *
   * @param skirmishID_: unique request ID
   * @param ship_: the contract to call
   * @param barrelORum_: the array of random integers
   *
   */
  function landHo(
    uint256 skirmishID_,
    address ship_,
    uint256[] calldata barrelORum_,
    string calldata apiResponse_,
    string calldata apiSignature_
  ) external payable {
    require(msg.sender == firstMate, "BelayThatFirstMateOnly");
    emit ArrrngServed(skirmishID_, apiResponse_, apiSignature_);
    IArrrrng(ship_).avast{value: msg.value}(skirmishID_, barrelORum_);
  }

  /**
   *
   * @dev avast: insufficient gas sent on call - instarefund
   *
   * @param skirmishID_: unique request ID
   * @param ship_: the contract to call
   *
   */
  function avast(uint256 skirmishID_, address ship_) external payable {
    require(msg.sender == firstMate, "BelayThatFirstMateOnly");

    emit ArrrngRefundInsufficientTokenForGasMatey(ship_, skirmishID_);

    (bool success, ) = ship_.call{value: msg.value}("");
    require(success, "TheTransferWalkedThePlank!(failed)");
  }
}
