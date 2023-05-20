// SPDX-License-Identifier: MIT

/**
 *
 * @title ArrngConsumer.sol. Use arrng
 *
 * @author arrng https://arrng.xyz/
 *
 */

import {IArrngConsumer} from "./IArrngConsumer.sol";

pragma solidity 0.8.19;

abstract contract ArrngConsumer is IArrngConsumer {
  address private immutable arrngController;

  /**
   * @dev constructor
   */
  constructor(address arrngController_) {
    arrngController = arrngController_;
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
   * @param barrelORum_: array of random integers requested
   *
   */
  function yarrrr(
    uint256 skirmishID_,
    uint256[] calldata barrelORum_
  ) external payable {
    require(msg.sender == arrngController, "BelayThatOfficersOnly");
    fulfillRandomWords(skirmishID_, barrelORum_);
  }
}
