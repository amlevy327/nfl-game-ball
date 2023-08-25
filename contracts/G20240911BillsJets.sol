// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract G20240911BillsJets is ERC721Enumerable  {
  using Counters for Counters.Counter;
  Counters.Counter private _nextTokenId;

  bytes32 public immutable GAME_ID;

  event GameBallCreated(bytes32 indexed gameId, uint256 tokenId, uint256 gameBallId);
  event GameBallNotesUpdated(uint256 gameBallId, string notes);
  event GameBallVerified(uint256 gameBallId, address indexed fanAddress);

  struct GameBall {
    uint256 id;
    string notes;
    address verifiedByAddress;
    bool verified;
    bool exists;
  }
  mapping(uint256 => GameBall) private _gameBalls;
  mapping(uint256 => uint256) private _tokenIdToGameBallId;
  mapping(uint256 => uint256) private _gameBallIdToTokenId;

  constructor(
    string memory name_,
    string memory symbol_
  ) ERC721(name_, symbol_)
  {
    GAME_ID = keccak256("G20240911BillsJets");
    // start at token id = 1
    _nextTokenId.increment();
  }

  /**
  ////////////////////////////////////////////////////
  // External Functions 
  ///////////////////////////////////////////////////
  */

  // Create game ball NFTs: called before game starts
  // TODO: for prod add access control (NFL)
  function createGameBalls(uint256[] memory ids_, address owner_) external {
    uint256 tokenId;
    for (uint256 i = 0; i < ids_.length; i++) {
      uint256 id = ids_[i];
      require(_gameBalls[id].exists == false, 'GAME_BALL_ID_EXISTS');
      tokenId = _nextTokenId.current();
      _mint(owner_, tokenId);
      _gameBalls[id] = GameBall({
        id: id,
        notes: "",
        verifiedByAddress: owner_,
        verified: false,
        exists: true
      });
      _tokenIdToGameBallId[tokenId] = id;
      _gameBallIdToTokenId[id] = tokenId;
      emit GameBallCreated(GAME_ID, tokenId, id);
      _nextTokenId.increment();
    }
  }

  // Add notes to game ball NFT: called after game event (during or after game)
  // TODO: for prod add access control (NFL)
  function addNotesToGameBall(uint256 id_, string memory notes_) external {
    require(_gameBalls[id_].exists == true, 'GAME_BALL_DOES_NOT_EXISTS');
    _gameBalls[id_].notes = notes_;
    emit GameBallNotesUpdated(id_, notes_);
  }

  // Verify game ball NFT: called after ball received and verified by fan
  // TODO: for prod add access control (NFL)
  function verifyGameBall(uint256 id_, address fan_) external {
    transferFrom(_gameBalls[id_].verifiedByAddress, fan_, _gameBallIdToTokenId[id_]);
    _gameBalls[id_].verifiedByAddress = fan_;
    _gameBalls[id_].verified = true;
    emit GameBallVerified(id_, fan_);
  }

  /**
  ////////////////////////////////////////////////////
  // View only functions
  ///////////////////////////////////////////////////
  */

  function gameBall(uint256 id) external view returns (GameBall memory) {
    require(_gameBalls[id].exists == true, 'GAME_BALL_DOES_NOT_EXISTS');
    return _gameBalls[id];
  }

  function tokenIdToGameBallId(uint256 tokenId) external view returns (uint256) {
    require(_exists(tokenId), 'TOKEN_ID_DOES_NOT_EXISTS');
    return _tokenIdToGameBallId[tokenId];
  }

  function gameBallIdToTokenId(uint256 id) external view returns (uint256) {
    require(_gameBalls[id].exists == true, 'GAME_BALL_DOES_NOT_EXISTS');
    return _gameBallIdToTokenId[id];
  }
}