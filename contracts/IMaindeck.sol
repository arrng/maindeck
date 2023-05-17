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
  event ENSLogLoggedInTheCaptainsLogOfLogsMatey(address newENSReverseRegistrar);
  event ColoursNailedToTheMastMatey(string ensName, bytes32 ensNameHash);
  event SmallestTreasureChestSetMatey(uint256 minimumNativeToken);
  event MostNumbersYeCanGetSetMatey(uint256 newNumberLimited);
  event YarrrOfficerOnDeckMatey(address oracle);
  event XMarksTheSpot(address treasury);

  event ArrrngRequest(
    address indexed caller,
    uint96 indexed requestId,
    uint64 numberOfNumbers,
    uint64 minValue,
    uint64 maxvalue,
    uint64 ethValue
  );

  event ArrrngResponse(bytes32 requestTxnHash);

  event ArrrngServed(
    uint256 indexed requestId,
    uint256[] randomNumbers,
    string apiResponse,
    string apiSignature
  );

  event ArrrngRefundInsufficientTokenForGas(
    address indexed caller,
    uint256 requestId
  );
}
