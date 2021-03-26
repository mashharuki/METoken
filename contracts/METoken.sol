pragma solidity >= 0.4.21;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract METoken is StandardToken {
    string public constant name = 'Mastering Ethereum Token';
    string public constant symbol = 'MET';
    uint8 public constant decimals = 2;
    uint constant _initial_supply = 2100000000;
    
    // constructor 
    function METoken() public {
        totalSupply_ = _initial_supply;
        // balance
        balances[msg.sender] = _initial_supply;
        // event
        emit Transfer(address(0), msg.sender, _initial_supply);
    }
}

