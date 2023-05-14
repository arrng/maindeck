// SPDX-License-Identifier: MIT

/**
 *
 * @title Arrrrng.sol. Use arrrrng
 *
 * @author arrrrng https://arrrrng.xyz/
 *
 */

pragma solidity 0.8.19;

abstract contract Arrrrng {
  address private immutable maindeck;

  /**
   * @dev constructor
   */
  constructor(address maindeck_) {
    maindeck = maindeck_;
  }

  /**
   *
   * @dev grogsUp: Do something with the RNG
   *
   * @param skirmishID_: unique ID for this request
   * @param barrelORum_: array of random integers requested
   *
   */
  function grogsUp(
    uint256 skirmishID_,
    uint256[] calldata barrelORum_
  ) internal virtual {}

  /**
   *
   * @dev avast: receive RNG
   *
   * @param skirmishID_: unique ID for this request
   * @param barrelORum_: array of random integers requested
   *
   */
  function avast(uint256 skirmishID_, uint256[] calldata barrelORum_) external {
    require(msg.sender == maindeck, "BelayThatMaindeckOnly");
    grogsUp(skirmishID_, barrelORum_);
  }
}
