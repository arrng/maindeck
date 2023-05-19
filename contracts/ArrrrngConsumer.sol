// SPDX-License-Identifier: MIT

/**
 *
 * @title Arrrrng.sol. Use arrrrng
 *
 * @author arrrrng https://arrrrng.xyz/
 *
 */

pragma solidity 0.8.19;

abstract contract ArrrrngConsumer {
  address private immutable maindeck;

  /**
   * @dev constructor
   */
  constructor(address maindeck_) {
    maindeck = maindeck_;
  }

  /**
   *
   * @dev ayeAye: Do something with the RNG
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
    require(msg.sender == maindeck, "BelayThatMaindeckOnly");
    fulfillRandomWords(skirmishID_, barrelORum_);
  }
}
