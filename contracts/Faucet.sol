pragma solidity >=0.4.22;

/**
 * 継承用テストコントラクト
 */
contract owned {
    address owner;
    
    // 引き出しを記録するためのイベント
    event Withdrawal (address indexed to, uint amount);
    // 預金を記録するためのイベント
    event Deposit (address indexed from, uint amount);
    
    constructor () payable {
        owner = msg.sender;
    }
    
    // アクセス制御修飾子
    modifier onlyOwner {
        require (msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
}

/**
 * 継承先テストコントラクト
 */
 contract mortal is owned {
     // コントラクトディストラクト関数
    function destroy () public onlyOwner {
        // コントラクトを破棄する。(自己消滅)
        selfdestruct(owner);
    } 
 }
 
contract Faucet is mortal {
    
    // アドレス
    address owner;
    
    // 引き出し関数
    // @_amount 引出額
    function withdraw (uint _amount) public {
        require (_amount <= 0.1 ether);
        require (this.balance >= _amount, "指定されたイーサを引き出すためのイーサがこのコントラクトにはありません。");
        msg.sender.transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }
    
    // 入金用フォールバック関数
    function fallback () public payable { 
        emit Deposit (msg.sender, msg.value);
    }
}
