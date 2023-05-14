// SPDX-License-Identifier: MIT

/**
 *
 * @title Maindeck.sol. Core contract for arrrrng.
 *
 * @author arrrrng https://arrrrng.xyz/
 *
 */

pragma solidity 0.8.19;

interface IMaindeck {
  event ENSLogLoggedInTheCaptainsLogOfLogs(address newENSReverseRegistrar);
  event ColoursNailedToTheMast(string name);
  event TreasureMapDrawn(uint256 newTreasureRequiredForGas);
  event ahoyThere(
    uint96 chainId,
    address caller,
    uint64 requestId,
    uint64 numberOfNumbers,
    uint64 minValue,
    uint64 maxvalue
  );
  event AyeAyeMatey(address oracle);
  event YoHoHo(uint256 newNumberLimited);
}
