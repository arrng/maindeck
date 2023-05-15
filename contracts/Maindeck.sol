// SPDX-License-Identifier: BUSL-1.1

/**
 *
 * @title Maindeck.sol. Core contract for arrrrng.
 *
 * @author arrrrng https://arrrrng.xyz/
 *
 */

pragma solidity 0.8.19;

import {IMaindeck} from "./IMaindeck.sol";
import {IENSReverseRegistrar} from "./ENS/IENSReverseRegistrar.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IArrrrng} from "./IArrrrng.sol";

contract Maindeck is IMaindeck, Ownable {
  // ETH required for gas cost to serve RNG
  uint256 public treasureRequired;

  // Address of the oracle
  address payable public firstMate;

  // Request ID:
  uint256 public skirmishID;

  // Limit on number of returned numbers
  uint256 public dubloonLimit;

  // Address of the ENS reverse registrar to allow assignment of an ENS
  // name to this contract:
  IENSReverseRegistrar public ensLog;

  /**
   * @dev constructor
   */
  constructor(address owner_) {
    _transferOwnership(owner_);
    dubloonLimit = 100000;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier garrCapnOnly() {
    _checkOwner();
    _;
  }

  /**
   * ---------------------
   * @dev CAPTAIN'S CABIN
   * ---------------------
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
    emit ENSLogLoggedInTheCaptainsLogOfLogs(ensRegistrar_);
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
    ensLog.setName(ensName_);
    emit ColoursNailedToTheMast(ensName_);
    (ensName_);
  }

  /**
   *
   * @dev xMarksTheSpot: set a new value of required ETH for gas
   *
   * @param gasFee_: the new eth fee
   *
   */
  function xMarksTheSpot(uint256 gasFee_) external garrCapnOnly {
    treasureRequired = gasFee_;
    emit TreasureMapDrawn(gasFee_);
  }

  /**
   *
   * @dev raiseTheJollyRoger: set a new max number
   *
   * @param maxNumbersPerTxn_: the new max requested numbers
   *
   */
  function raiseTheJollyRoger(uint256 maxNumbersPerTxn_) external garrCapnOnly {
    dubloonLimit = maxNumbersPerTxn_;
    emit DubloonLimitDoBeUpdated(maxNumbersPerTxn_);
  }

  /**
   *
   * @dev promoteToFirstMate: set a new oracle address
   *
   * @param oracle_: the new oracle address
   *
   */
  function promoteToFirstMate(address payable oracle_) external garrCapnOnly {
    firstMate = oracle_;
    emit AyeAyeMatey(oracle_);
  }

  /**
   * -----------------------
   * @dev HOIST THE MAINSAIL
   * -----------------------
   */

  /**
   *
   * @dev ahoy: request RNG
   *
   * @param numberOfNumbers_: the amount of numbers to request
   * @param minValue_: the min of the range
   * @param maxValue_: the max of the range
   *
   */
  function ahoy(
    uint256 numberOfNumbers_,
    uint256 minValue_,
    uint256 maxValue_
  ) external payable {
    skirmishID += 1;

    require(msg.value >= treasureRequired, "ThisDoBeNotEnoughETHForGasMatey");

    require(numberOfNumbers_ > 0, "GarrrNotEnoughNumbers");

    require(numberOfNumbers_ <= dubloonLimit, "GarrrTooManyNumbers");

    (bool success, ) = firstMate.call{value: msg.value}("");
    require(success, "TheTransferWalkedThePlank!(failed)");

    emit ahoyThere(
      msg.sender,
      uint96(skirmishID),
      uint64(numberOfNumbers_),
      uint64(minValue_),
      uint64(maxValue_),
      uint64(msg.value)
    );
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
    string calldata apiSignature_,
    string calldata verificationSite_
  ) external payable {
    require(msg.sender == firstMate, "BelayThatFirstMateOnly");
    emit YoHoHo(skirmishID_, apiResponse_, apiSignature_, verificationSite_);
    IArrrrng(ship_).avast{value: msg.value}(skirmishID_, barrelORum_);
  }

  /**
   *
   * @dev avast: insufficient gas sent on call - refund
   *
   * @param skirmishID_: unique request ID
   * @param ship_: the contract to call
   *
   */
  function avast(uint256 skirmishID_, address ship_) external payable {
    require(msg.sender == firstMate, "BelayThatFirstMateOnly");

    emit InsufficientGasForTransactionRefundApplied(ship_, skirmishID_);

    (bool success, ) = ship_.call{value: msg.value}("");
    require(success, "TheTransferWalkedThePlank!(failed)");
  }
}
