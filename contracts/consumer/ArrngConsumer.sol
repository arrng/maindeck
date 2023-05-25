// SPDX-License-Identifier: MIT

/**
 *
 * @title ArrngConsumer.sol. Use arrng
 *
 * @author arrng https://arrng.xyz/
 *
 */

import {IArrngConsumer} from "./IArrngConsumer.sol";
import {IArrngController} from "../controller/IArrngController.sol";

pragma solidity 0.8.19;

abstract contract ArrngConsumer is IArrngConsumer {
  IArrngController public immutable arrngController;

  /**
   * @dev constructor
   */
  constructor(address arrngController_) {
    arrngController = IArrngController(arrngController_);
  }

  /**
   *
   * @dev fulfillRandomWords: Do something with the RNG
   *
   * @param requestId: unique ID for this request
   * @param randomWords: array of random integers requested
   *
   */
  function fulfillRandomWords(
    uint256 requestId,
    uint256[] memory randomWords
  ) internal virtual;

  /**
   *
   * @dev yarrrr: receive RNG
   *
   * @param skirmishID_: unique ID for this request
   * @param barrelONum_: array of random integers requested
   *
   */
  function yarrrr(
    uint256 skirmishID_,
    uint256[] calldata barrelONum_
  ) external payable {
    require(msg.sender == address(arrngController), "BelayThatOfficersOnly");
    fulfillRandomWords(skirmishID_, barrelONum_);
  }
}
