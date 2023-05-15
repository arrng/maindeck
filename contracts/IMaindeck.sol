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
    address indexed caller,
    uint96 indexed requestId,
    uint64 numberOfNumbers,
    uint64 minValue,
    uint64 maxvalue,
    uint64 ethValue
  );

  event YoHoHo(
    uint256 indexed requestId,
    string apiResponse,
    string apiSignature,
    string verificationSite
  );

  event AyeAyeMatey(address oracle);
  event DubloonLimitDoBeUpdated(uint256 newNumberLimited);
  event InsufficientGasForTransactionRefundApplied(
    address indexed caller,
    uint256 requestId
  );
}
