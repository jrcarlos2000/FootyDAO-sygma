pragma solidity ^0.8.18;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
contract FootyDAOAdapter is Ownable{
    event Withdrawn(uint256 indexed_amount, uint256 _gameId);
    address public paymentToken;
    mapping(uint256 => uint256) public gameIdBalances;
    constructor(address _paymentToken) Ownable(msg.sender){
        paymentToken = _paymentToken;
    }
    function joinGame(uint256 _gameId, uint256 _amount) public {
        IERC20(paymentToken).transferFrom(msg.sender, address(this), _amount);
        gameIdBalances[_gameId] += _amount;
    }
    function withdraw(uint256 _gameId) public onlyOwner {
        uint256 amount = gameIdBalances[_gameId];
        gameIdBalances[_gameId] = 0;
        IERC20(paymentToken).transfer(msg.sender, amount);
        emit Withdrawn(amount, _gameId);
    }
}