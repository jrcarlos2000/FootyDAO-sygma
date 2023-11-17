pragma solidity ^0.8.18;

contract FootyDAO {
    uint256 gameCounter = 0;
    mapping(uint256 => address) public gameOwner;
    mapping(uint256 => bool) public isOpen;

    function createGame() public {
        gameCounter += 1;
        gameOwner[gameCounter] = msg.sender;
        isOpen[gameCounter] = true;
    }
    function getOwner(uint256 _gameId) public view returns (address) {
        return gameOwner[_gameId];
    }

    function closeGame(uint256 _gameId) public {
        isOpen[_gameId] = false;
    }
}