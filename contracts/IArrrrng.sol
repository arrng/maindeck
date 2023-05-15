// SPDX-License-Identifier: MIT

/**
 *
 * @title IArrrrng.sol. Use arrrrng
 *
 * @author arrrrng https://arrrrng.xyz/
 *
 */

pragma solidity 0.8.19;

interface IArrrrng {
  /**
   *
   * @dev avast: receive RNG
   *
   * @param skirmishID_: unique ID for this request
   * @param barrelORum_: array of random integers requested
   *
   */
  function avast(
    uint256 skirmishID_,
    uint256[] memory barrelORum_
  ) external payable;
}
